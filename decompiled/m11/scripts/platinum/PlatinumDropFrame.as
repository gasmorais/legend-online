package platinum
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.cccactive.PlatinaItemInfoMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.PlatinumManager;
   import mvc.module.platinum.PlatinumModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   
   public class PlatinumDropFrame extends Frame implements IManualSize
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _goodsListView:Sprite;
      
      private var _scrollPanel:ScrollPanel;
      
      private var type:int;
      
      public function PlatinumDropFrame(param1:int)
      {
         super();
         type = param1;
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,433,245);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("bottle.view.BottleDropFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleDropFrame.Bg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleDropScrollPanel");
         addToContent(_bg);
         addToContent(_scrollPanel);
         initGoodsListView();
      }
      
      private function initGoodsListView() : void
      {
         var _loc8_:GoodsInfo = null;
         var _loc1_:PlatinumDropItem = null;
         var _loc2_:Bitmap = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         _goodsListView = new Sprite();
         var _loc4_:Array = [];
         var _loc3_:Array = type == 0 ? model.goldItemInfo : model.platinumItemInfo;
         for each(var _loc6_:PlatinaItemInfoMsg in _loc3_)
         {
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc6_.templateId;
            _loc8_.count = _loc6_.count;
            if(_loc8_.templateInfo)
            {
               _loc4_.push(_loc8_);
            }
         }
         _loc7_ = Math.ceil(_loc4_.length / 3);
         _loc4_.sort(sortFun);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_ = new PlatinumDropItem();
            _loc1_.x = 6 + _loc5_ % 3 * _loc1_.displayWidth;
            _loc1_.y = int(_loc5_ / 3) * _loc1_.displayHeight;
            _loc1_.data = _loc4_[_loc5_];
            _goodsListView.addChild(_loc1_);
            if(_loc5_ % 3 == 0 && _loc5_ != _loc4_.length - 1)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.bottle.DropFrameLine");
               _loc2_.y = _loc1_.y + _loc1_.displayHeight - _loc2_.height;
               _goodsListView.addChild(_loc2_);
            }
            _loc5_++;
         }
         if(_loc7_ > 0)
         {
            _goodsListView.scrollRect = new Rectangle(0,0,588,_loc7_ * _loc1_.displayHeight);
         }
         _scrollPanel.setView(_goodsListView);
      }
      
      protected function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = int(param1.templateInfo.SonType);
         var _loc4_:int = int(param2.templateInfo.SonType);
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         return 0;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : PlatinumModel
      {
         return PlatinumManager.instance.model;
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_goodsListView);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

