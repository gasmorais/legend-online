package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallTeamInfo;
   import yishi.filter.UIFilter;
   
   public class GameHallTeamItemView extends Component implements ISelectable, IListCell
   {
      
      private var _bg:Image;
      
      private var _flagImg:Image;
      
      private var _titleTxt:FilterFrameText;
      
      private var _mineTeamTxt:FilterFrameText;
      
      private var _lockImg:Image;
      
      private var _infoView1:GameHallTeamInfoView;
      
      private var _infoView2:GameHallTeamInfoView;
      
      private var _infoView3:GameHallTeamInfoView;
      
      private var _infoView4:GameHallTeamInfoView;
      
      private var _gamingFlagImg:Image;
      
      private var _filter:UIFilter;
      
      private var _data:GameHallTeamInfo;
      
      protected var _selected:Boolean;
      
      public function GameHallTeamItemView()
      {
         super();
         initView();
         addEvent();
         clean();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.bg");
         _flagImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.flagImg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.titleTxt");
         _mineTeamTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.mineTeamTxt");
         _lockImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.lockImg");
         _infoView1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.infoView1");
         _infoView2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.infoView2");
         _infoView3 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.infoView3");
         _infoView4 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.infoView4");
         _gamingFlagImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamItemView.gamingFlagImg");
         _titleTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallTeamItemView.titleTxt",1);
         _mineTeamTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallTeamItemView.mineTeamTxt");
         addChild(_bg);
         addChild(_flagImg);
         addChild(_titleTxt);
         addChild(_mineTeamTxt);
         addChild(_lockImg);
         addChild(_infoView1);
         addChild(_infoView2);
         addChild(_infoView3);
         addChild(_infoView4);
         addChild(_gamingFlagImg);
         _filter = new UIFilter();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_flagImg);
         _flagImg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_mineTeamTxt);
         _mineTeamTxt = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_infoView1);
         _infoView1 = null;
         ObjectUtils.disposeObject(_infoView2);
         _infoView2 = null;
         ObjectUtils.disposeObject(_infoView3);
         _infoView3 = null;
         ObjectUtils.disposeObject(_infoView4);
         _infoView4 = null;
         ObjectUtils.disposeObject(_gamingFlagImg);
         _gamingFlagImg = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _filter = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
         _infoView1.addEventListener("click",__infoViewClickHandler);
         _infoView2.addEventListener("click",__infoViewClickHandler);
         _infoView3.addEventListener("click",__infoViewClickHandler);
         _infoView4.addEventListener("click",__infoViewClickHandler);
      }
      
      private function removeEvent() : void
      {
         _infoView1.removeEventListener("click",__infoViewClickHandler);
         _infoView2.removeEventListener("click",__infoViewClickHandler);
         _infoView3.removeEventListener("click",__infoViewClickHandler);
         _infoView4.removeEventListener("click",__infoViewClickHandler);
      }
      
      private function __infoViewClickHandler(param1:MouseEvent) : void
      {
         GameHallManager.instance.teamInfo(_data.teamId);
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1 as GameHallTeamInfo;
         clean();
         if(_data)
         {
            refresh();
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
      }
      
      private function clean() : void
      {
         _lockImg.visible = false;
         _mineTeamTxt.visible = false;
         _gamingFlagImg.visible = false;
      }
      
      private function refresh() : void
      {
         var _loc4_:int = 0;
         _lockImg.visible = _data.isLock;
         _mineTeamTxt.visible = _data.isMine;
         _titleTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallTeamItemView.titleTxt",_data.teamId);
         var _loc1_:Boolean = false;
         if(_data.teamState == 1)
         {
            _loc1_ = true;
         }
         _gamingFlagImg.visible = _loc1_;
         if(_loc1_)
         {
            _filter.setGrayFilter(this);
         }
         else
         {
            _filter.setNormalFilter(this);
         }
         var _loc2_:int = int(_data.players.length);
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = _loc4_ + 1;
            if(_loc4_ < _loc2_)
            {
               this["_infoView" + _loc3_].data = _data.players[_loc4_];
               this["_infoView" + _loc3_].refreshTeamFlag(_data);
            }
            else
            {
               this["_infoView" + _loc3_].data = null;
            }
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

