package consortia.view.crossguild
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.crossguild.view.CrossGuildBufferSelectFrame;
   import consortia.view.crossguild.view.CrossGuildBufferView;
   import consortia.view.crossguild.view.CrossGuildDefendListView;
   import consortia.view.crossguild.view.CrossGuildSeasonView;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class CrossGuildPolicyFrame extends Frame implements IManualSize
   {
      
      private var _bufferNameText:FilterFrameText;
      
      private var _guildBufferText:FilterFrameText;
      
      private var _seasonView:CrossGuildSeasonView;
      
      private var _bufferView:CrossGuildBufferView;
      
      private var _defendListView:CrossGuildDefendListView;
      
      private var _profileImage:ScaleFrameImage;
      
      private var _skillIcon:BaseIconView;
      
      private var _modifyBtn:IconButton;
      
      private var _mBack:MutipleImage;
      
      private var _helpBtn:BaseButton;
      
      public function CrossGuildPolicyFrame()
      {
         super();
         initView();
         addEvent();
         CrossGuildManager.instance.sendFrameRequest(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,820,625);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _seasonView = ComponentFactory.Instance.creatCustomObject("CrossGuild.CrossGuildPolicyFrame.seasonView");
         _bufferView = ComponentFactory.Instance.creatCustomObject("CrossGuild.CrossGuildPolicyFrame.bufferView");
         _defendListView = ComponentFactory.Instance.creatCustomObject("CrossGuild.CrossGuildPolicyFrame.defendListView");
         _modifyBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildPolicyFrame.modifyBtn");
         _mBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildPolicyFrame.mBack");
         _profileImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuildPolicyFrame.profileImage");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("CrossGuildPolicyFrame.skillIcon");
         _guildBufferText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildPolicyFrame.guildBufferText");
         _bufferNameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildPolicyFrame.bufferNameText");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("CrossGuild.helpBtn.tipData");
         addToContent(_helpBtn);
         _helpBtn.x = 775;
         _helpBtn.y = 10;
         addToContent(_mBack);
         addToContent(_seasonView);
         addToContent(_defendListView);
         addToContent(_skillIcon);
         addToContent(_profileImage);
         addToContent(_bufferNameText);
         addToContent(_guildBufferText);
         addToContent(_bufferView);
         addToContent(_modifyBtn);
         _profileImage.mouseEnabled = false;
         _profileImage.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _modifyBtn.addEventListener("click",_modifyBtnClickHandler);
         MsgMan.addObserver("CROSS_GUILD_MAIN_CHANGE",this,__updatePolicyHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_modifyBtn)
         {
            _modifyBtn.removeEventListener("click",_modifyBtnClickHandler);
         }
         MsgMan.removeObserver("CROSS_GUILD_MAIN_CHANGE",this,__updatePolicyHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpClickHandler);
         }
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.helperFrame");
         _loc2_.show();
      }
      
      private function __updatePolicyHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         refreshView();
         _seasonView.refreshView();
         if(_loc3_ == 12)
         {
            _bufferView.refreshView(false);
         }
         else
         {
            _bufferView.refreshView(true);
         }
         _defendListView.refreshView();
      }
      
      private function _modifyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CrossGuildBufferSelectFrame = ComponentFactory.Instance.creatComponentByStylename("crossguild.CrossGuildBufferSelectFrame");
         _loc2_.show();
      }
      
      private function refreshView() : void
      {
         _modifyBtn.visible = consorModel.consortiaInfo.chairmanID == playerInfo.userId;
         var _loc1_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[model.guildShowBufferId];
         if(_loc1_)
         {
            _profileImage.visible = _loc1_.Grades > 1;
            _profileImage.setFrame(_loc1_.Grades - 1);
            _skillIcon.icon = IconFactory.getTecIconByIcon(_loc1_.Icons);
            _skillIcon.tipData = _loc1_;
            _guildBufferText.text = _loc1_.Description;
            _bufferNameText.text = _loc1_.TemplateName;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_crossgvg");
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      private function get consorModel() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bufferNameText);
         _bufferNameText = null;
         ObjectUtils.disposeObject(_guildBufferText);
         _guildBufferText = null;
         ObjectUtils.disposeObject(_seasonView);
         _seasonView = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         ObjectUtils.disposeObject(_defendListView);
         _defendListView = null;
         ObjectUtils.disposeObject(_modifyBtn);
         _modifyBtn = null;
         ObjectUtils.disposeObject(_mBack);
         _mBack = null;
         ObjectUtils.disposeObject(_profileImage);
         _profileImage = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         CrossGuildManager.instance.sendCrossGuildWar(13);
         super.dispose();
      }
   }
}

