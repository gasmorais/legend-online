package gamehall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GamehallEastDropTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class GameHallEastShopResultFrame extends Frame implements IManualSize
   {
      
      private var _sprite:Sprite;
      
      private var _titleImage:Image;
      
      private var _confimBtn:IconButton;
      
      private var _model:GameHallModel;
      
      public function GameHallEastShopResultFrame()
      {
         super();
         _model = GameHallManager.instance.model;
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopResultFrame.titleImage");
         _confimBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopResultFrame.confimBtn");
         addToContent(_titleImage);
         addToContent(_confimBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_confimBtn);
         _confimBtn = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_confimBtn)
         {
            _confimBtn.addEventListener("click",__confimBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confimBtn)
         {
            _confimBtn.removeEventListener("click",__confimBtnHandler);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __confimBtnHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP"];
      }
      
      private function initData() : void
      {
         var _loc4_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc5_:int = 0;
         var _loc3_:GamehallEastDropTemplate = null;
         var _loc1_:Array = _model.eastLotteryIdArr;
         if(_loc1_)
         {
            _loc4_ = int(_loc1_.length);
            _sprite = new Sprite();
            if(_loc4_ == 1)
            {
               _sprite.x = 220;
               _sprite.y = 90;
            }
            else
            {
               _sprite.x = 80;
               _sprite.y = 50;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = new GoodsInfo();
               _loc3_ = TempleteManager.instance.gamehallEastShopTempCate.getTemplateByID(_loc1_[_loc5_]);
               if(_loc3_)
               {
                  _loc6_.templateId = _loc3_.itemId;
               }
               _loc6_.count = 1;
               _loc2_ = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallEastShopResultFrame.BaseItemView");
               _loc2_.x = 6 + _loc5_ % 5 * 65;
               _loc2_.y = int(_loc5_ / 5) * 65;
               _loc2_.data = _loc6_;
               _sprite.addChild(_loc2_);
               _loc5_++;
            }
            addToContent(_sprite);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,498,244);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

