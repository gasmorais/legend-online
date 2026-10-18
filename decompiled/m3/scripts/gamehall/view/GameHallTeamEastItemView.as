package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.view.community.BaseIconView;
   
   public class GameHallTeamEastItemView extends Component
   {
      
      private var _selectedImage:ScaleFrameImage;
      
      private var _bgFrameImage:ScaleFrameImage;
      
      private var _mapIcon:BaseIconView;
      
      private var _campaignNameTxt:FilterFrameText;
      
      private var _costGoodsImage:Image;
      
      private var _costGoodsNumTxt:FilterFrameText;
      
      private var _model:GameHallModel;
      
      private var _data:GameHallEasterTemplateInfo;
      
      private var _selected:Boolean;
      
      public function GameHallTeamEastItemView()
      {
         super();
         _model = GameHallManager.instance.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _selectedImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastItemView.selectedImage");
         _bgFrameImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastItemView.bgFrameImage");
         _mapIcon = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallTeamEastItemView.mapIcon",[loadComplete]);
         _campaignNameTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.campaignNameTxt");
         _costGoodsImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.costGoodsImage");
         _costGoodsNumTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastItemView.costGoodsNumTxt");
         addChild(_selectedImage);
         _selectedImage.width = 206;
         addChild(_bgFrameImage);
         addChild(_mapIcon);
         addChild(_campaignNameTxt);
         addChild(_costGoodsImage);
         _costGoodsImage.x = 120;
         _costGoodsImage.y = 58;
         addChild(_costGoodsNumTxt);
         _costGoodsNumTxt.x = 150;
         _costGoodsNumTxt.y = 65;
         _selectedImage.visible = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bgFrameImage);
         _bgFrameImage = null;
         ObjectUtils.disposeObject(_mapIcon);
         _mapIcon = null;
         ObjectUtils.disposeObject(_campaignNameTxt);
         _campaignNameTxt = null;
         ObjectUtils.disposeObject(_costGoodsImage);
         _costGoodsImage = null;
         ObjectUtils.disposeObject(_costGoodsNumTxt);
         _costGoodsNumTxt = null;
         ObjectUtils.disposeObject(_selectedImage);
         _selectedImage = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseOver",__mouseOverHandler);
         this.addEventListener("mouseOut",__mouseOutHandler);
         this.addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",__mouseOverHandler);
         this.removeEventListener("mouseOut",__mouseOutHandler);
         this.removeEventListener("click",__mouseClickHandler);
      }
      
      public function __mouseOverHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data.TemplateId == _model.selectedDifficulty)
         {
            return;
         }
         _selectedImage.visible = true;
      }
      
      public function __mouseOutHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data.TemplateId == _model.selectedDifficulty)
         {
            return;
         }
         _selectedImage.visible = false;
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.selectedDifficulty = _data.TemplateId;
         _model.selectedGameId = 4;
         _model.updateSelectedGameInfo();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectedImage.visible = param1;
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
            _costGoodsImage.visible = _bgFrameImage.visible = _costGoodsNumTxt.visible = true;
            _mapIcon.visible = _campaignNameTxt.visible = _selectedImage.visible = true;
            refreshView();
         }
         else
         {
            clear();
         }
      }
      
      private function clear() : void
      {
         this.filters = [UIFilter.getGrayFilter()];
         _costGoodsImage.visible = _bgFrameImage.visible = _costGoodsNumTxt.visible = false;
         _mapIcon.visible = _campaignNameTxt.visible = _selectedImage.visible = false;
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         if(_model.selectedDifficulty == _data.TemplateId)
         {
            _selectedImage.visible = true;
         }
         else
         {
            _selectedImage.visible = false;
         }
         if(_data.TicketCount > _model.tickes)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            this.filters = [UIFilter.getLightingFilter()];
         }
         _costGoodsNumTxt.text = "x" + _data.TicketCount;
         if(_data.PreView)
         {
            _loc1_ = _data.PreView.split(",")[0];
            _loc2_ = int(_data.PreView.split(",")[1]);
            _mapIcon.icon = PathManager.eastSmallCampaignByUrl(_loc1_);
            _bgFrameImage.setFrame(_loc2_);
            _campaignNameTxt.setFrame(_loc2_);
            _campaignNameTxt.text = _data.TemplateName;
         }
      }
      
      private function loadComplete(param1:BaseIconView = null) : void
      {
         (_mapIcon.content as Bitmap).smoothing = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

