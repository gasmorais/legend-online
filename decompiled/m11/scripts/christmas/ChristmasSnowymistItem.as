package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.christmas.SnowyMistMsg;
   import com.road.yishi.proto.christmas.SnowyMistTeamPlayerMsg;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ChristmasManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChristmasSnowymistItem extends Sprite implements Disposeable
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
      
      private var _kickoutBtn:IconButton;
      
      private var _data:SnowyMistMsg;
      
      private var _player:SnowyMistTeamPlayerMsg;
      
      private var _index:int;
      
      public function ChristmasSnowymistItem(param1:int)
      {
         super();
         _index = param1;
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
         _kickoutBtn = ComponentFactory.Instance.creatComponentByStylename("ChristmasSnowymistItem.kickoutBtn");
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
         addChild(_kickoutBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         this.addEventListener("click",__clickHanlder);
         _kickoutBtn.addEventListener("click",__kickoutBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         this.removeEventListener("click",__clickHanlder);
         _kickoutBtn.removeEventListener("click",__kickoutBtnClickHandler);
      }
      
      private function __kickoutBtnClickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(20,_player.userId);
      }
      
      private function __clickHanlder(param1:MouseEvent) : void
      {
         if(model.opType == 0)
         {
            ChristmasManager.instance.opRequest(18,_data.teamId);
         }
         else if(model.opType == 1)
         {
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _selectedImg.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _selectedImg.visible = false;
      }
      
      public function get data() : SnowyMistMsg
      {
         return _data;
      }
      
      public function set data(param1:SnowyMistMsg) : void
      {
         clean();
         _data = param1;
         if(data)
         {
            _player = _data.teamPlayers[_index];
            if(_player)
            {
               refresh();
            }
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
         _kickoutBtn.visible = false;
      }
      
      private function refresh() : void
      {
         _icon.icon = IconFactory.getPlayerIcon(_player.headId,"head");
         _nameTxt.text = _player.nickName;
         _consortiaNameTxt.text = _player.consortiaName;
         _levelTxt.text = _player.grade.toString();
         _add.visible = false;
         _icon.visible = true;
         _nameTxt.visible = true;
         _consortiaNameTxt.visible = true;
         _levelBg.visible = true;
         _levelTxt.visible = true;
         if(_data.teamLeaderUserId == _player.userId)
         {
            _leader.visible = true;
         }
         else
         {
            _leader.visible = false;
            if(_data.teamLeaderUserId == playerInfo.userId)
            {
               _kickoutBtn.visible = true;
            }
         }
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
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
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

