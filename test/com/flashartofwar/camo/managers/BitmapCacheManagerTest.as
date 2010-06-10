package com.flashartofwar.camo.managers
{
    import flash.display.Bitmap;

    import flash.display.BitmapData;

    import flexunit.framework.Assert;


    public class BitmapCacheManagerTest
    {
        private var bmc:BitmapCacheManager;

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
            Assert.assertTrue(bmc.hasBitmap("foobar"))
        }
        
        [Test]
        public function testHasBitmapThatDoesNotExist():void
        {
            Assert.assertFalse(bmc.hasBitmap("foobar2"));
        }

        [Test(expected="Error")]
        public function testErrorFromOverride():void
        {
            bmc.overrideBitmaps == false;
            bmc.addBitmap("foobar",  new Bitmap(new BitmapData(200,200)));
        }

        [Test]
        public function testGetBitmap():void
        {
            var bmd:Bitmap = bmc.getBitmap("foobar");
            Assert.assertNotNull(bmd);
            Assert.assertEquals(bmd.width, 400);
            Assert.assertEquals(bmd.height, 500);
        }

        [Test]
        public function testGetBitmapThatDoesNotExist():void
        {
            var bmd:Bitmap = bmc.getBitmap("foobar2");
            Assert.assertNull(bmd);
        }

    }
}