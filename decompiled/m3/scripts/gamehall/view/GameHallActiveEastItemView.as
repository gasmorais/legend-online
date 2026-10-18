package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GameHallEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallBlessInfo;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class GameHallActiveEastItemView extends Sprite
   {
      
      private var _selectedImage:ScaleFrameImage;
      
      private var _bgFrameImage:ScaleFrameImage;
      
      private var _mapIcon:BaseIconView;
      
      private var _campaignNameTxt:FilterFrameText;
      
      private var _lookImage:Image;
      
      private var _costGoodsImage:Image;
      
      private var _costGoodsNumTxt:FilterFrameText;
      
      private var _enterBtn:BaseButton;
      
      private var _selected:Boolean;
      
      private var _callBack:Function;
      
      private var _model:GameHallModel;
      
      private var _data:GameHallEasterTemplateInfo;
      
      public function GameHallActiveEastItemView(param1:Function = null)
      {
         super();
         _callBack = param1;
         _model = GameHallManager.instance.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _selectedImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.selectedImage");
         _bgFrameImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.bgFrameImage");
         _mapIcon = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallEastItemView.mapIcon",[loadComplete]);
         _campaignNameTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.campaignNameTxt");
         _lookImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.lookImage");
         _costGoodsImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.costGoodsImage");
         _costGoodsNumTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.costGoodsNumTxt");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.enterBtn");
         addChild(_selectedImage);
         addChild(_bgFrameImage);
         addChild(_mapIcon);
         addChild(_campaignNameTxt);
         addChild(_lookImage);
         addChild(_costGoodsImage);
         addChild(_costGoodsNumTxt);
         addChild(_enterBtn);
         _selectedImage.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_selectedImage);
         _selectedImage = null;
         ObjectUtils.disposeObject(_bgFrameImage);
         _bgFrameImage = null;
         ObjectUtils.disposeObject(_mapIcon);
         _mapIcon = null;
         ObjectUtils.disposeObject(_campaignNameTxt);
         _campaignNameTxt = null;
         ObjectUtils.disposeObject(_lookImage);
         _lookImage = null;
         ObjectUtils.disposeObject(_costGoodsImage);
         _costGoodsImage = null;
         ObjectUtils.disposeObject(_costGoodsNumTxt);
         _costGoodsNumTxt = null;
         ObjectUtils.disposeObject(_enterBtn);
         _enterBtn = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _callBack = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         if(_enterBtn)
         {
            _enterBtn.addEventListener("click",__enterBtnHandler);
         }
         this.addEventListener("mouseOver",__mouseOverHandler);
         this.addEventListener("mouseOut",__mouseOutHandler);
         this.addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_enterBtn)
         {
            _enterBtn.removeEventListener("click",__enterBtnHandler);
         }
         this.removeEventListener("mouseOver",__mouseOverHandler);
         this.removeEventListener("mouseOut",__mouseOutHandler);
         this.removeEventListener("click",__mouseClickHandler);
      }
      
      private function __enterBtnHandler(param1:MouseEvent) : void
      {
         model.openEastView = true;
         model.selectedDifficulty = _data.TemplateId;
         if(_callBack != null)
         {
            _callBack();
         }
      }
      
      public function get data() : GameHallEasterTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:GameHallEasterTemplateInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _lookImage.visible = _costGoodsImage.visible = _bgFrameImage.visible = _costGoodsNumTxt.visible = true;
            _enterBtn.visible = _mapIcon.visible = _campaignNameTxt.visible = _selectedImage.visible = true;
            refreshView();
         }
         else
         {
            clear();
         }
      }
      
      private function clear() : void
      {
         selected = false;
         _lookImage.visible = _costGoodsImage.visible = _bgFrameImage.visible = _costGoodsNumTxt.visible = false;
         _enterBtn.visible = _mapIcon.visible = _campaignNameTxt.visible = _selectedImage.visible = false;
      }
      
      private function refreshView() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = int(_model.selectedDifficulty);
         var _loc1_:Boolean = false;
         if(_data)
         {
            if(_loc4_ == _data.TemplateId)
            {
               _loc1_ = true;
            }
            selected = _loc1_;
            _costGoodsNumTxt.text = "x" + _data.TicketCount;
            if(_data.PreView)
            {
               _loc2_ = _data.PreView.split(",")[0];
               _loc3_ = int(_data.PreView.split(",")[1]);
               _mapIcon.icon = PathManager.eastSmallCampaignByUrl(_loc2_);
               _bgFrameImage.setFrame(_loc3_);
               _campaignNameTxt.setFrame(_loc3_);
               _campaignNameTxt.text = _data.TemplateName;
            }
            setLookImageTips();
         }
      }
      
      private function setLookImageTips() : void
      {
         var _loc4_:GameHallBlessInfo = null;
         var _loc10_:int = 0;
         var _loc1_:GameHallBlessInfo = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!_data)
         {
            return;
         }
         var _loc9_:String = _data.DropWishes;
         if(StringHelper.isNullOrEmpty(_loc9_))
         {
            _lookImage.tipData = [];
            return;
         }
         if(!_model.wishArray)
         {
            return;
         }
         var _loc8_:Array = [];
         var _loc11_:Array = _loc9_.split(",");
         var _loc2_:int = int(_loc11_.length);
         var _loc5_:Array = _model.wishArray;
         var _loc3_:int = int(_loc5_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc10_ = int(_loc11_[_loc6_]);
            _loc4_ = new GameHallBlessInfo();
            _loc4_.skillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_loc10_);
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc1_ = _loc5_[_loc7_];
               if(_loc1_ && _loc1_.skillTempInfo && _loc1_.skillTempInfo.TemplateId == _loc10_)
               {
                  _loc4_.level = _loc1_.level;
                  break;
               }
               _loc7_++;
            }
            _loc8_.push(_loc4_);
            _loc6_++;
         }
         _lookImage.tipData = _loc8_;
      }
      
      private function __gameInfoUpdateHandler(param1:GameHallEvent) : void
      {
         refreshView();
      }
      
      private function get model() : GameHallModel
      {
         return GameHallManager.instance.model;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectedImage.visible = _selected;
      }
      
      public function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_data && _data.TemplateId == _model.selectedDifficulty)
         {
            return;
         }
         if(_selectedImage)
         {
            _selectedImage.visible = true;
         }
      }
      
      public function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(_data && _data.TemplateId == _model.selectedDifficulty)
         {
            return;
         }
         if(_selectedImage)
         {
            _selectedImage.visible = false;
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.selectedDifficulty = _data.TemplateId;
         _model.selectedGameId = 4;
         _model.updateSelectedGameInfo();
      }
      
      private function loadComplete(param1:BaseIconView = null) : void
      {
         (_mapIcon.content as Bitmap).smoothing = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

