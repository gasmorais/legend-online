package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import map.campaign.data.ActiveVehicleAccountInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class ActiveVehicleAccountBottomView extends Component
   {
      
      private static const MINRANK:int = 200;
      
      private var _back:ScaleBitmapImage;
      
      private var _bg:Scale9CornerImage;
      
      private var _award1:Bitmap;
      
      private var _award2:Bitmap;
      
      private var _icon1:BaseItemView;
      
      private var _icon2:BaseItemView;
      
      private var _numberAsset:BitmapData;
      
      private var _symbolBit1:Bitmap;
      
      private var _symbolBit2:Bitmap;
      
      private var _value1:Sprite;
      
      private var _value2:Sprite;
      
      private var _templateId1:int = 2060067;
      
      private var _templateId3:int = 3020010;
      
      private var _numStr:String = "0123456789.";
      
      private var _spline:Bitmap;
      
      private var _vehicleInfo:ActiveVehicleAccountInfo;
      
      public function ActiveVehicleAccountBottomView(param1:ActiveVehicleAccountInfo)
      {
         _vehicleInfo = param1;
         super();
         NumberViewUtils.getNumberView(param1.propCount,_value1,_numberAsset,20,23,13,20,_numStr,1);
         NumberViewUtils.getNumberView(param1.ladderCount,_value2,_numberAsset,20,23,13,20,_numStr,1);
      }
      
      override protected function init() : void
      {
         var _loc1_:GoodsInfo = null;
         var _loc2_:GoodsInfo = null;
         _back = ComponentFactory.Instance.creatComponentByStylename("vehicle.SortListBg");
         _back.height = 81;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ActiveVehicleAccountBottomView.sortBg");
         _bg.x = 4;
         _bg.y = 5;
         _award1 = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.Image1");
         _award2 = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.Image2");
         _icon1 = ComponentFactory.Instance.creatCustomObject("ActiveVehicleAccountBottomView.rewardIcon1");
         _icon2 = ComponentFactory.Instance.creatCustomObject("ActiveVehicleAccountBottomView.rewardIcon2");
         _award1.x = 20;
         _award1.y = -6;
         _award2.x = 300;
         _award2.y = -6;
         _symbolBit1 = ComponentFactory.Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         _symbolBit2 = ComponentFactory.Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         _symbolBit1.x = 67;
         _symbolBit1.y = 40;
         _symbolBit2.x = 347;
         _symbolBit2.y = 40;
         _numberAsset = ComponentFactory.Instance.creatBitmapData("worldboss.river.NumberAsset");
         _value1 = new Sprite();
         _value2 = new Sprite();
         _value1.x = 82;
         _value1.y = 38;
         _value2.x = 363;
         _value2.y = 38;
         _spline = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.AccountViewSpline");
         _spline.x = 280;
         _spline.y = 5;
         addChild(_back);
         addChild(_bg);
         addChild(_award1);
         addChild(_award2);
         addChild(_spline);
         if(_vehicleInfo.awardPropId != 0)
         {
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = _vehicleInfo.awardPropId;
            _icon1.data = _loc1_;
            addChild(_icon1);
            addChild(_symbolBit1);
            addChild(_value1);
         }
         if(_vehicleInfo.ladderPropId != 0)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _vehicleInfo.ladderPropId;
            _icon2.data = _loc2_;
            addChild(_icon2);
            addChild(_symbolBit2);
            addChild(_value2);
         }
      }
      
      override public function dispose() : void
      {
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_award1)
         {
            ObjectUtils.disposeObject(_award1);
         }
         _award1 = null;
         if(_award2)
         {
            ObjectUtils.disposeObject(_award2);
         }
         _award2 = null;
         if(_icon1)
         {
            ObjectUtils.disposeObject(_icon1);
         }
         _icon1 = null;
         if(_icon2)
         {
            ObjectUtils.disposeObject(_icon2);
         }
         _icon2 = null;
         if(_numberAsset)
         {
            ObjectUtils.disposeObject(_numberAsset);
         }
         _numberAsset = null;
         if(_symbolBit1)
         {
            ObjectUtils.disposeObject(_symbolBit1);
         }
         _symbolBit1 = null;
         if(_symbolBit2)
         {
            ObjectUtils.disposeObject(_symbolBit2);
         }
         _symbolBit2 = null;
         if(_value1)
         {
            ObjectUtils.disposeObject(_value1);
         }
         _value1 = null;
         if(_value2)
         {
            ObjectUtils.disposeObject(_value2);
         }
         _value2 = null;
         if(_spline)
         {
            ObjectUtils.disposeObject(_spline);
         }
         _spline = null;
         super.dispose();
      }
   }
}

