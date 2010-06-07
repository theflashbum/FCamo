/**
 * <p>Original Author:  jessefreeman</p>
 * <p>Class File: LoaderManager.as</p>
 *
 * <p>Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:</p>
 *
 * <p>The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.</p>
 *
 * <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.</p>
 *
 * <p>Licensed under The MIT License</p>
 * <p>Redistributions of files must retain the above copyright notice.</p>
 *
 * <p>Revisions<br/>
 *     2.0  Initial version Jan 7, 2009</p>
 *
 */

package com.flashartofwar.camo.managers {
    import com.flashartofwar.camo.events.LoaderManagerEvent;

    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;

    public class LoaderManager extends EventDispatcher implements ILoaderManager {

        protected var _loadQueue:Array = [];
        protected var _loading:Boolean;
        protected var _currentlyLoadingFile:String;
        public var defaultDelimiter:String = "/";
        public var loaded:Array = [];
        public var loadedReference:Dictionary = new Dictionary(true);
        public var totalPreloading:Number = 0;
        public var totalPreloaded:Number = 0;
        public var context:LoaderContext = new LoaderContext(true, ApplicationDomain.currentDomain);

        /**
         *
         *
         */
        public function LoaderManager() {
            _loading = false;
        }

        /**
         *
         * @param url
         *
         */
        public function load(url:String, loaderContext:LoaderContext = null):void {
            var fileName:String = url;
            if (! loadedReference[fileName]) {
                if (_loading) {
                    _loadQueue.push(url);
                }
                else {
                    _loading = true;
                    var path:URLRequest = new URLRequest(url);
                    var loader:Loader = new Loader();
                    _currentlyLoadingFile = fileName;
                    addListeners(loader.contentLoaderInfo);
                    loader.load(path, (loaderContext) ? loaderContext : context);
                }
            }
            else {
                // Remove first item in the queue
                _loadQueue = _loadQueue.slice(1);
                //var id : int = loaded.indexOf( loadedReference[fileName] );
                dispatchEvent(new LoaderManagerEvent(LoaderManagerEvent.LOADED, {fileName:fileName}, true, true));
                preload();
            }
        }

        /**
         *
         * @param list
         *
         */
        public function addToQueue(list:Array):void {
            _loadQueue = _loadQueue.concat(list);
            totalPreloading += _loadQueue.length;

            if (! _loading) {
                preload();
            }
        }

        /**
         * begins preload by seeing if the counter is lower then the total pages to load. If more
         * loading is needed, the preloader calls the loadPage. If preloading is complete, a
         * PRELOAD_DONE e is dispatched.
         */
        protected function preload():void {
            if (_loadQueue.length >= 1) {
                load(_loadQueue[0]);
                totalPreloaded ++;
                dispatchEvent(new LoaderManagerEvent(LoaderManagerEvent.PRELOAD_NEXT, {totalPreloaded: totalPreloaded, totalPreloading: totalPreloading, fileName:_loadQueue[0]}, true, true));
            }
            else {
                dispatchEvent(new LoaderManagerEvent(LoaderManagerEvent.PRELOAD_DONE, {totalPreloaded: totalPreloaded}, true, true));

                // Clear preloading counter
                totalPreloading = 0;
                totalPreloaded = 0;
            }
        }

        /**
         * <p>This is called when swf is loaded. After loading, the listeners are removed
         * and preload is recalled to continue with the preloading process.</p>
         */
        protected function onLoadComplete(e:Event):void {
            e.stopImmediatePropagation();

            // Remove first item in the queue
            _loadQueue = _loadQueue.slice(1);

            // Toggle loading to false
            _loading = false;

            // Isolate loaded data from e target
            var info:LoaderInfo = e.target as LoaderInfo;
            var loader:Loader = info.loader;

            registerLoader(_currentlyLoadingFile, loader);

            // Remove loading listeners
            removeListeners(info);
            loader = null;

            dispatchEvent(new LoaderManagerEvent(LoaderManagerEvent.LOADED, {fileName:_currentlyLoadingFile}, true, true));

            // clear currently loaded file name
            _currentlyLoadingFile = null;

            // Recall preloader to keep going through the Queue
            preload();
        }

        /**
         *
         * @param loader
         * @return
                *
         */
        protected function registerLoader(id:String, loader:Loader):void {
            loaded.push(loader);
            loadedReference[id] = loader;
        }

        /**
         * <p>attaches listeners to LoaderInfo. This is used to streamline the repetitive adding of
         * listeners in the preload process.</p>
         *
         * @param target
         *
         */
        protected function addListeners(target:LoaderInfo):void {
            target.addEventListener(Event.COMPLETE, onLoadComplete);
            target.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
            target.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            target.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        private function onLoaderProgress(event:ProgressEvent):void {
            event.stopPropagation();
            dispatchEvent(new LoaderManagerEvent(LoaderManagerEvent.PROGRESS, {percent: event.bytesLoaded / event.bytesTotal, bytesLoaded: event.bytesLoaded, bytesTotal: event.bytesTotal}));
        }

        /**
         * <p>removes listeners to LoaderInfo. This is used to streamline the remove of listeners
         * from the preload process and frees up memory.</p>
         */
        protected function removeListeners(target:LoaderInfo):void {
            target.removeEventListener(Event.COMPLETE, onLoadComplete);
            target.removeEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
            target.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
            target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        /**
         *
         */
        protected function onSecurityError(e:SecurityErrorEvent):void {
            e.stopImmediatePropagation();
            trace("ExternalSwfLoader: Securty error while loading '" + _currentlyLoadingFile + "'.");
            abortLoad();
        }

        /**
         *
         */
        protected function onIOError(e:IOErrorEvent):void {
            e.stopImmediatePropagation();
            trace("ExternalSwfLoader: onIOError error while loading '" + _currentlyLoadingFile + "'.");
            abortLoad();
        }

        /**
         *
         *
         */
        public function abortLoad():void {
            _currentlyLoadingFile = null;


            // Remove first item in the queue
            _loadQueue = _loadQueue.slice(1);

            // Toggle loading to false
            _loading = false;

            // Recall preloader to keep going through the Queue
            preload();
        }

        /**
         *
         *
         */
        public function flush():void {
            // reset arrays just to make sure
            loaded = new Array();
            loadedReference = new Dictionary(true);
        }
    }
}