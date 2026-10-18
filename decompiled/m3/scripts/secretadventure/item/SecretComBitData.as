package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import yishi.utils.SimpleDictionary;
   
   public class SecretComBitData
   {
      
      private static var _instance:SecretComBitData;
      
      public var event:BitmapData;
      
      public var empty:BitmapData;
      
      public var walk:BitmapData;
      
      public var grassEvent:BitmapData;
      
      public var grassEmpty:BitmapData;
      
      public var redBit:BitmapData;
      
      public var copyBit:Bitmap;
      
      private var _mapBitmapDic:SimpleDictionary;
      
      public function SecretComBitData()
      {
         super();
         _mapBitmapDic = new SimpleDictionary();
      }
      
      public static function get Instance() : SecretComBitData
      {
         if(_instance == null)
         {
            _instance = new SecretComBitData();
         }
         return _instance;
      }
      
      public function putBitMap(param1:int, param2:BitmapData) : void
      {
         _mapBitmapDic.add(param1,param2);
      }
      
      public function getBitMap(param1:int) : BitmapData
      {
         return _mapBitmapDic[param1];
      }
      
      public function setup() : void
      {
         event = ComponentFactory.Instance.creatBitmap("asset.secretad.event").bitmapData;
         empty = ComponentFactory.Instance.creatBitmap("asset.secret.empty").bitmapData;
         walk = ComponentFactory.Instance.creatBitmap("asset.secret.click").bitmapData;
         grassEvent = ComponentFactory.Instance.creatBitmap("asset.secretad.grassEvent").bitmapData;
         grassEmpty = ComponentFactory.Instance.creatBitmap("asset.secretad.grassEmpty").bitmapData;
         copyBit = ComponentFactory.Instance.creatBitmap("asset.secretad.copyBit");
         redBit = ComponentFactory.Instance.creatBitmap("asset.secretad.redBox").bitmapData;
      }
      
      public function disposeBitDatas() : void
      {
         if(redBit)
         {
            redBit.dispose();
         }
         redBit = null;
         if(event)
         {
            event.dispose();
         }
         event = null;
         if(empty)
         {
            empty.dispose();
         }
         empty = null;
         if(walk)
         {
            walk.dispose();
         }
         walk = null;
         if(grassEvent)
         {
            grassEvent.dispose();
         }
         grassEvent = null;
         if(grassEmpty)
         {
            grassEmpty.dispose();
         }
         grassEmpty = null;
         if(_mapBitmapDic)
         {
            _mapBitmapDic.clear();
         }
      }
   }
}

