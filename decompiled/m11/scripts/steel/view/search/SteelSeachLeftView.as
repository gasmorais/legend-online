package steel.view.search
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.data.SteelTeamInfo;
   import map.campaign.event.SteelEvent;
   import mvc.controler.SteelController;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.ResourceManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SteelSeachLeftView extends Sprite implements Disposeable
   {
      
      private var _leftBg:Scale9CornerImage;
      
      private var _titlebarBg:MutipleImage;
      
      private var _listBg:Scale9CornerImage;
      
      private var _applyBtn:IconButton;
      
      private var _createBtn:IconButton;
      
      private var _refreshBtn:IconButton;
      
      private var _teamNameTxt:FilterFrameText;
      
      private var _hostNameTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _teamItemGroup:SelectedButtonGroup;
      
      private var _teamItemList:Vector.<SteelTeamInfoItem>;
      
      private var _controller:SteelController = FrameControllerManager.instance.steelController;
      
      private var _model:SteelModel = _controller.model;
      
      private const CREATE_TEAM_GOLD_USE:int = 1000000;
      
      public function SteelSeachLeftView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SteelTeamInfoItem = null;
         _teamItemList = new Vector.<SteelTeamInfoItem>();
         _teamItemGroup = new SelectedButtonGroup();
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.Bg");
         _listBg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.ListBg");
         _titlebarBg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.TitleGap");
         _teamNameTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.TeamNameTxt");
         _hostNameTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.HostNameTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.FightPowerTxt");
         _applyBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.ApplyBtn");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.CreateBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchLeftView.RefreshBtn");
         _teamNameTxt.text = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TitleTxt01");
         _hostNameTxt.text = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TitleTxt02");
         _fightPowerTxt.text = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TitleTxt03");
         addChild(_leftBg);
         addChild(_listBg);
         addChild(_titlebarBg);
         addChild(_teamNameTxt);
         addChild(_hostNameTxt);
         addChild(_fightPowerTxt);
         addChild(_applyBtn);
         addChild(_createBtn);
         addChild(_refreshBtn);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new SteelTeamInfoItem();
            _loc1_.x = 7;
            _loc1_.y = 35 + _loc2_ * (_loc1_.height - 1);
            addChild(_loc1_);
            _teamItemGroup.addSelectItem(_loc1_);
            _teamItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function uninitView() : void
      {
         for each(var _loc1_:SteelTeamInfoItem in _teamItemList)
         {
            _loc1_.dispose();
         }
         _teamItemList = null;
         _teamItemGroup.dispose();
         _teamItemGroup = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _applyBtn.addEventListener("click",__applyBtnClickHandler);
         _createBtn.addEventListener("click",__createBtnClickHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _model.addEventListener("STEEL_TEAM_LIST_CHANGE",__teamListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _applyBtn.removeEventListener("click",__applyBtnClickHandler);
         _createBtn.removeEventListener("click",__createBtnClickHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _model.removeEventListener("STEEL_TEAM_LIST_CHANGE",__teamListChangeHandler);
      }
      
      private function __teamListChangeHandler(param1:SteelEvent) : void
      {
         refreshView();
      }
      
      private function __createBtnClickHandler(param1:MouseEvent) : void
      {
         createTeam();
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         for each(var _loc2_:SteelTeamInfoItem in _teamItemList)
         {
            _loc2_.setCheckState(false);
         }
         _controller.sendSteelListTeams();
      }
      
      private function createTeam() : void
      {
         SimpleAlertHelper.instance.data = [createTeamCallBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TipsTxt01");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,true);
      }
      
      private function createTeamCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            if(ResourceManager.instance.gold.count < 1000000)
            {
               _loc3_ = LanguageMgr.GetTranslation("public.gold");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            FrameControllerManager.instance.steelController.sendSteelCreateTeam();
         }
      }
      
      private function __applyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc5_:SteelTeamInfo = null;
         var _loc4_:int = 0;
         SoundManager.instance.play("022");
         var _loc2_:Array = getSelectedItem();
         if(!_loc2_ || _loc2_.length <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TipsTxt02");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(_loc2_.length + _model.applyList.length > 5)
         {
            _loc3_ = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TipsTxt05");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_] as SteelTeamInfo;
            FrameControllerManager.instance.steelController.sendSteelApplyEnter(_loc5_.teamUid);
            _loc4_++;
         }
      }
      
      private function getSelectedItem() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:SteelTeamInfoItem in _teamItemList)
         {
            if(_loc2_.data)
            {
               if(_loc2_.checked)
               {
                  _loc1_.push(_loc2_.data);
               }
            }
         }
         return _loc1_;
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = _model.teamList;
         _loc1_ = 0;
         while(_loc1_ < _teamItemList.length)
         {
            _teamItemList[_loc1_].data = _loc1_ < _loc2_.length ? SteelTeamInfo(_loc2_[_loc1_]) : null;
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

