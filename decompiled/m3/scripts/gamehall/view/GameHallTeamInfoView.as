package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.gamehall.GameHallTeamInfo;
   import mvc.module.gamehall.GameHallUserInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GameHallTeamInfoView extends Component
   {
      
      private var _bg:Image;
      
      private var _add:Image;
      
      private var _icon:BaseIconView;
      
      private var _leader:Image;
      
      private var _nameTxt:FilterFrameText;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      private var _levelBg:Image;
      
      private var _levelTxt:FilterFrameText;
      
      private var _selectedImg:Image;
      
      private var _data:GameHallUserInfo;
      
      public function GameHallTeamInfoView()
      {
         super();
         initView();
         addEvent();
         clean();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.bg");
         _selectedImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.selectedImg");
         _add = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.add");
         _icon = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallTeamInfoView.icon");
         _leader = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.leader");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.nameTxt");
         _consortiaNameTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.consortiaNameTxt");
         _levelBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.levelBg");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamInfoView.levelTxt");
         _nameTxt.text = "";
         _consortiaNameTxt.text = "";
         _levelTxt.text = "";
         _selectedImg.visible = false;
         addChild(_bg);
         addChild(_selectedImg);
         addChild(_add);
         addChild(_icon);
         addChild(_leader);
         addChild(_nameTxt);
         addChild(_consortiaNameTxt);
         addChild(_levelBg);
         addChild(_levelTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_selectedImg);
         _selectedImg = null;
         ObjectUtils.disposeObject(_add);
         _add = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_leader);
         _leader = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_consortiaNameTxt);
         _consortiaNameTxt = null;
         ObjectUtils.disposeObject(_levelBg);
         _levelBg = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _data = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _selectedImg.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _selectedImg.visible = false;
      }
      
      public function get data() : GameHallUserInfo
      {
         return _data;
      }
      
      public function set data(param1:GameHallUserInfo) : void
      {
         clean();
         _data = param1;
         if(data)
         {
            refresh();
         }
      }
      
      private function clean() : void
      {
         _add.visible = true;
         _icon.visible = false;
         _leader.visible = false;
         _nameTxt.visible = false;
         _consortiaNameTxt.visible = false;
         _levelBg.visible = false;
         _levelTxt.visible = false;
      }
      
      private function refresh() : void
      {
         _icon.icon = IconFactory.getPlayerIcon(_data.headId,"head");
         _nameTxt.text = data.nickName;
         _consortiaNameTxt.text = data.consortiaName;
         _levelTxt.text = data.grade.toString();
         _add.visible = false;
         _icon.visible = true;
         _nameTxt.visible = true;
         _consortiaNameTxt.visible = true;
         _levelBg.visible = true;
         _levelTxt.visible = true;
      }
      
      public function refreshTeamFlag(param1:GameHallTeamInfo) : void
      {
         if(param1 && param1.captainId == _data.userId)
         {
            _leader.visible = true;
         }
         else
         {
            _leader.visible = false;
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

