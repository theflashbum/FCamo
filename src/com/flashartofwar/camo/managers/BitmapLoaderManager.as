/**
 * <p>Original Author:  jessefreeman</p>
 * <p>Class File: BitmapLoaderManager.as</p>
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
 * 	2.0  Initial version Jan 7, 2009</p>
 *
 */

package com.flashartofwar.camo.managers
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;

    public class BitmapLoaderManager extends LoaderManager
    {
        /**
         *
         *
         */
        public function BitmapLoaderManager()
        {
            super();
        }

        /**
         *
         * @param loader
         * @return
         *
         */
        override protected function registerLoader(id:String, loader:Loader):void
        {
            var bmd:BitmapData = Bitmap(loader.content).bitmapData.clone();
            var bitmap:Bitmap = new Bitmap(bmd);

            loadedReference[id] = bitmap;
        }
    }
}