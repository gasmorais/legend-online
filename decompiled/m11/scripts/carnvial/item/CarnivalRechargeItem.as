package carnvial.item
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CarnivalLuckDrawTemplateInfo;
   import yishi.manager.CarnivalManager;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseItemView;
   
   public class CarnivalRechargeItem extends Sprite
   {
      
      private var _item:BaseItemView;
      
      private var _light:Bitmap;
      
      private var _luckBit:Bitmap;
      
      private var _luckbg:Bitmap;
      
      private var _luckComponent:Component;
      
      private var _type:int;
      
      private const TYPE_GOODS:int = 1;
      
      private var _isDie:Boolean;
      
      private var _tempInfo:CarnivalLuckDrawTemplateInfo;
      
      private var _isLight:Boolean;
      
      public var idx:int;
      
      public function CarnivalRechargeItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         if(_type == 1)
         {
            _item = ComponentFactory.Instance.creatCustomObject("LuckyLotteryGoodsItem.baseItemView");
            addChild(_item);
         }
         else
         {
            _luckComponent = ComponentFactory.Instance.creatCustomObject("ui.carnivar.rechargeOutItem");
            _luckbg = ComponentFactory.Instance.creatBitmap("asset.carniver.rewardState");
            _luckBit = new Bitmap();
            _luckBit.x = 5;
            _luckBit.y = 7;
            addChild(_luckComponent);
            _luckComponent.addChild(_luckbg);
            _luckComponent.addChild(_luckBit);
            _loc1_ = int(CarnivalManager.Instance.model.configActId);
            toLoadImg(_luckBit,"tab2_icon",_loc1_);
         }
         _light = ComponentFactory.Instance.creatBitmap("asset.carniver.rewardLight");
         addChild(_light);
         isLight = false;
      }
      
      private function toLoadImg(param1:Bitmap, param2:String, param3:int) : void
      {
         var bit:Bitmap = param1;
         var imgName:String = param2;
         var activeId:int = param3;
         var path:String = PathManager.getCarnivalRes(activeId,imgName);
         LoaderManagerII.instance.load(path,2,0,function(param1:LoaderInfo, param2:Object):void
         {
            if(!_isDie && param1.args && param2 is Bitmap)
            {
               param1.args.bitmapData = param2.bitmapData;
               _luckBit.width = 50;
               _luckBit.height = 50;
            }
         },null,null,bit);
      }
      
      public function dispose() : void
      {
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_luckBit);
         _luckBit = null;
         ObjectUtils.disposeObject(_luckComponent);
         _luckComponent = null;
         ObjectUtils.disposeObject(_luckbg);
         _luckbg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set tempInfo(param1:CarnivalLuckDrawTemplateInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         _tempInfo = param1;
         if(_tempInfo && _type == 1)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _tempInfo.Item;
            _loc2_.count = _tempInfo.ItemNum;
            _item.data = _loc2_;
         }
      }
      
      public function get tempInfo() : CarnivalLuckDrawTemplateInfo
      {
         return _tempInfo;
      }
      
      public function set isLight(param1:Boolean) : void
      {
         _isLight = param1;
         _light.visible = _isLight;
      }
      
      public function get isLight() : Boolean
      {
         return _isLight;
      }
   }
}

