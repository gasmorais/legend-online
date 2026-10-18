package crisis.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class PlaneCrisisComBitData
   {
      
      private static var _instance:PlaneCrisisComBitData;
      
      public var cloudGray:BitmapData;
      
      public var cloudRed:BitmapData;
      
      public var cloudBlue:BitmapData;
      
      public var cloudYellow:BitmapData;
      
      public var cloudGreen:BitmapData;
      
      public var eventBox:BitmapData;
      
      public var eventKey:BitmapData;
      
      public var eventCloud:BitmapData;
      
      public var eventElargment:BitmapData;
      
      public var eventSmallBoss:BitmapData;
      
      public var eventBigBoss:BitmapData;
      
      public var eventRewardBox:BitmapData;
      
      public var colorDic:Dictionary;
      
      public var smallLight:BitmapData;
      
      public function PlaneCrisisComBitData()
      {
         super();
      }
      
      public static function get Instance() : PlaneCrisisComBitData
      {
         if(_instance == null)
         {
            _instance = new PlaneCrisisComBitData();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         var _loc1_:int = 0;
         cloudGray = ComponentFactory.Instance.creatBitmap("asset.planecrisis.CloudGray").bitmapData;
         cloudRed = ComponentFactory.Instance.creatBitmap("asset.planecrisis.CloudRed").bitmapData;
         cloudBlue = ComponentFactory.Instance.creatBitmap("asset.planecrisis.CloudBlue").bitmapData;
         cloudYellow = ComponentFactory.Instance.creatBitmap("asset.planecrisis.CloudYellow").bitmapData;
         cloudGreen = ComponentFactory.Instance.creatBitmap("asset.planecrisis.CloudGreen").bitmapData;
         eventBox = ComponentFactory.Instance.creatBitmap("asset.planecrisis.mapBox").bitmapData;
         eventRewardBox = ComponentFactory.Instance.creatBitmap("asset.planecrisis.mapRewardBox").bitmapData;
         eventKey = ComponentFactory.Instance.creatBitmap("asset.planecrisis.mapKey").bitmapData;
         eventCloud = ComponentFactory.Instance.creatBitmap("asset.planecrisis.mapCloud").bitmapData;
         eventElargment = ComponentFactory.Instance.creatBitmap("asset.planecrisis.mapElargment").bitmapData;
         eventSmallBoss = ComponentFactory.Instance.creatBitmap("asset.planecrisis.mapSmallBoss").bitmapData;
         eventBigBoss = ComponentFactory.Instance.creatBitmap("asset.planecrisis.mapBigBoss").bitmapData;
         smallLight = ComponentFactory.Instance.creatBitmap("asset.planecrisis.smallMapLightPoint").bitmapData;
         colorDic = new Dictionary();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            colorDic[_loc1_] = ComponentFactory.Instance.creatBitmap("asset.planecrisis.RColor" + _loc1_);
            _loc1_++;
         }
      }
      
      public function disposeBitDatas() : void
      {
         if(cloudGray)
         {
            cloudGray.dispose();
         }
         cloudGray = null;
         if(cloudRed)
         {
            cloudRed.dispose();
         }
         cloudRed = null;
         if(cloudBlue)
         {
            cloudBlue.dispose();
         }
         cloudBlue = null;
         if(cloudYellow)
         {
            cloudYellow.dispose();
         }
         cloudYellow = null;
         if(cloudGreen)
         {
            cloudGreen.dispose();
         }
         cloudGreen = null;
         if(eventBox)
         {
            eventBox.dispose();
         }
         eventBox = null;
         if(eventRewardBox)
         {
            eventRewardBox.dispose();
         }
         eventRewardBox = null;
         if(eventKey)
         {
            eventKey.dispose();
         }
         eventKey = null;
         if(eventCloud)
         {
            eventCloud.dispose();
         }
         eventCloud = null;
         if(eventElargment)
         {
            eventElargment.dispose();
         }
         eventElargment = null;
         if(eventSmallBoss)
         {
            eventSmallBoss.dispose();
         }
         eventSmallBoss = null;
         if(eventBigBoss)
         {
            eventBigBoss.dispose();
         }
         eventBigBoss = null;
         if(smallLight)
         {
            smallLight.dispose();
         }
         smallLight = null;
         for each(var _loc1_:Bitmap in colorDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         colorDic = null;
      }
   }
}

