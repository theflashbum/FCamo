package com.flashartofwar.camo.managers
{
    import com.flashartofwar.camo.events.BitmapCacheManagerEvent;

    import flash.display.Bitmap;

    import flash.display.BitmapData;

    import flash.events.Event;

    import flexunit.framework.Assert;

    import org.flexunit.async.Async;


    public class BitmapCacheManagerTest
    {
        private var bmc:BitmapCacheManager;
        private const BITMAP_1:String = "foobar";
        private const BITMAP_2:String = "foobar2";

        public function BitmapCacheManagerTest()
        {
        }

        [Before]
        public function runBeforeEveryTest():void
        {
            bmc = new BitmapCacheManager();
            bmc.addBitmap("foobar", new Bitmap(new BitmapData(400, 500)), false);
        }

        [After]
        public function runAfterEveryTest():void
        {
            bmc = null;
        }

        [Test]
        public function testHasBitmap():void
        {
            Assert.assertTrue(bmc.hasBitmap(BITMAP_1))
        }
        
        [Test]
        public function testHasBitmapThatDoesNotExist():void
        {
            Assert.assertFalse(bmc.hasBitmap(BITMAP_2));
        }

        [Test(expected="Error")]
        public function testErrorFromOverride():void
        {
            bmc.overrideBitmaps = false;
            bmc.addBitmap(BITMAP_1,  new Bitmap(new BitmapData(200,200)));
        }

        [Test]
        public function testGetBitmap():void
        {
            var bmd:Bitmap = bmc.getBitmap(BITMAP_1);
            Assert.assertNotNull(bmd);
            Assert.assertEquals(bmd.width, 400);
            Assert.assertEquals(bmd.height, 500);
        }

        [Test]
        public function testAddBitmapIsLoading():void
        {
           bmc.addBitmap(BITMAP_2, new Bitmap(), true);
           Assert.assertTrue(bmc.isLoading(BITMAP_2)); 
        }

        [Test]
        public function testGetBitmapThatDoesNotExist():void
        {
            var bmd:Bitmap = bmc.getBitmap(BITMAP_2);
            Assert.assertNull(bmd);
        }

        [Test]
        public function testFlagAsLoading():void
        {
            bmc.flagAsLoading(BITMAP_2);
            Assert.assertTrue(bmc.isLoading(BITMAP_2));
        }

        [Test]
        public function testFlagAsLoadingThatDoesntExist():void
        {
            Assert.assertFalse(bmc.isLoading(BITMAP_2));
        }

        [Test]
        public function testFlagAsLoaded():void
        {
            bmc.flagAsLoading(BITMAP_2);
            bmc.flagAsLoaded(BITMAP_2);
            Assert.assertFalse(bmc.isLoading(BITMAP_2));
        }

        [Test(async)]
        public function testFlagAsLoadedAndEventFired():void
        {
            bmc.addEventListener(BitmapCacheManagerEvent.COMPLETE, Async.asyncHandler(this, handleLoadCompleteEvent, 500, null, handleLoadCompleteEventTimeout), false, 0, true);
            bmc.flagAsLoading(BITMAP_2);
            bmc.flagAsLoaded(BITMAP_2);
        }

        protected function handleLoadCompleteEvent(event:BitmapCacheManagerEvent, passThroughData:Object):void
        {
            Assert.assertTrue(true);
        }

        protected function handleLoadCompleteEventTimeout(passThroughData:Object):void
        {
            Assert.fail("Complete event never fired.");
        }

        [Test(async)]
        public function testRemoveBitmapAndEventFired():void
        {
            bmc.addEventListener(BitmapCacheManagerEvent.REMOVED, Async.asyncHandler(this, handleRemoveEvent, 500, null, handleRemoveEventTimeout), false, 0, true);
            bmc.removeBitmap(BITMAP_1);
        }

        protected function handleRemoveEvent(event:BitmapCacheManagerEvent, passThroughData:Object):void
        {
            Assert.assertTrue(true);
        }

        protected function handleRemoveEventTimeout(passThroughData:Object):void
        {
            Assert.fail("Removed event never fired.");
        }

        [Test]
        public function removeBitmap():void
        {
            bmc.removeBitmap(BITMAP_1);
            Assert.assertFalse(bmc.hasBitmap(BITMAP_1));
        }

        [Test]
        public function testUpdateBitmap():void
        {
            var tmpBitmap:Bitmap = new Bitmap(new BitmapData(25, 75));
            bmc.overrideBitmaps = true;
            bmc.updateBitmap(BITMAP_1, tmpBitmap);
            var returnedBitmap:Bitmap = bmc.getBitmap(BITMAP_1);
            Assert.assertEquals(returnedBitmap.width, 25);
            Assert.assertEquals(returnedBitmap.height, 75);
        }

        [Test(async)]
        public function testUpdateBitmapAndEventFired():void
        {
            bmc.addEventListener(BitmapCacheManagerEvent.CHANGE, Async.asyncHandler(this, handleUpdateEvent, 500, null, handleUpdateEventTimeout), false, 0, true);
            bmc.overrideBitmaps = true;
            bmc.updateBitmap(BITMAP_1, new Bitmap());
        }

        protected function handleUpdateEvent(event:BitmapCacheManagerEvent, passThroughData:Object):void
        {
            Assert.assertTrue(true);
        }

        protected function handleUpdateEventTimeout(passThroughData:Object):void
        {
            Assert.fail("Change event never fired.");
        }

        [Test(async)]
        public function testAddBitmapThatExistsAndEventFired():void
        {
            bmc.addEventListener(BitmapCacheManagerEvent.CHANGE, Async.asyncHandler(this, handleAddUpdateEvent, 500, null, handleAddUpdateEventTimeout), false, 0, true);
            bmc.overrideBitmaps = true;
            bmc.addBitmap(BITMAP_1, new Bitmap());
        }

        protected function handleAddUpdateEvent(event:BitmapCacheManagerEvent, passThroughData:Object):void
        {
            Assert.assertTrue(true);
        }

        protected function handleAddUpdateEventTimeout(passThroughData:Object):void
        {
            Assert.fail("Change event never fired.");
        }

    }
}