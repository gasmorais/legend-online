package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildMemberInfo;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class CrossGuildBufferItem extends Component
   {
      
      private var _giveUpText:FilterFrameText;
      
      private var _descText:FilterFrameText;
      
      private var _nickNameText:FilterFrameText;
      
      private var _itemBack:Image;
      
      private var _profileImage:ScaleFrameImage;
      
      private var _skillIcon:BaseIconView;
      
      private var _selectBtn:IconButton;
      
      private var _data:SkillTempInfo;
      
      private var memberInfo:CrossGuildMemberInfo;
      
      public function CrossGuildBufferItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _giveUpText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildBufferItem.giveUpText");
         _descText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildBufferItem.descText");
         _nickNameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildBufferItem.nameText");
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildBufferItem.itemBack");
         _profileImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferItem.profileImage");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("CrossGuildBufferItem.skillIcon");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferItem.selectBtn");
         addChild(_itemBack);
         addChild(_skillIcon);
         addChild(_profileImage);
         addChild(_nickNameText);
         addChild(_descText);
         addChild(_selectBtn);
         addChild(_giveUpText);
         _profileImage.mouseEnabled = false;
         _profileImage.visible = false;
         _giveUpText.mouseEnabled = true;
      }
      
      private function addEvent() : void
      {
         _selectBtn.addEventListener("click",__selectSkillHandler);
         _giveUpText.addEventListener("click",_giveUpClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__selectSkillHandler);
         }
         if(_giveUpText)
         {
            _giveUpText.removeEventListener("click",_giveUpClickHandler);
         }
      }
      
      private function __selectSkillHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         CrossGuildManager.instance.sendBufferSelect(12,data.TemplateId);
      }
      
      private function _giveUpClickHandler(param1:MouseEvent) : void
      {
         if(memberInfo && memberInfo.userId == playerInfo.userId)
         {
            CrossGuildManager.instance.sendBufferSelect(12,0);
         }
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(data)
         {
            _skillIcon.visible = true;
            _selectBtn.visible = true;
            _skillIcon.icon = IconFactory.getTecIconByIcon(data.Icons);
            _skillIcon.tipData = data;
            _descText.text = data.Description;
            _profileImage.visible = data.Grades > 1;
            _profileImage.setFrame(data.Grades - 1);
            memberInfo = model.getMemberDataByBufferId(data.TemplateId);
            if(memberInfo)
            {
               _nickNameText.text = memberInfo.nickName;
               _selectBtn.visible = false;
               if(memberInfo.userId == playerInfo.userId && model.state != 5 && model.state != 6)
               {
                  _giveUpText.htmlText = LanguageMgr.GetTranslation("CrossGuildBufferItem.giveUpText.text");
                  _giveUpText.mouseEnabled = true;
               }
               else
               {
                  _giveUpText.htmlText = "";
                  _giveUpText.mouseEnabled = false;
               }
            }
            else
            {
               _nickNameText.text = "";
               _selectBtn.visible = true;
               _selectBtn.enable = model.state == 4 && Boolean(model.getIsInDefend(playerInfo.userId));
               _giveUpText.mouseEnabled = false;
               _giveUpText.htmlText = "";
            }
         }
         else
         {
            _profileImage.visible = false;
            _skillIcon.visible = false;
            _selectBtn.visible = false;
            _giveUpText.text = "";
            _giveUpText.mouseEnabled = false;
            _nickNameText.text = "";
            _descText.text = "";
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_giveUpText);
         _giveUpText = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_nickNameText);
         _nickNameText = null;
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_profileImage);
         _profileImage = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         super.dispose();
      }
   }
}

