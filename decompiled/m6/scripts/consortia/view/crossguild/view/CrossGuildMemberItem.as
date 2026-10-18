package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.crossguild.CrossGuildMemberInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class CrossGuildMemberItem extends Component
   {
      
      private var _contributionText:FilterFrameText;
      
      private var _fightText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _rankText:FilterFrameText;
      
      private var _fightImage:Image;
      
      private var _line:Image;
      
      private var _profileImage:ScaleFrameImage;
      
      private var _skillIcon:BaseIconView;
      
      private var _heroIcon:BaseIconView;
      
      private var showType:int;
      
      private var index:int;
      
      private var _data:CrossGuildMemberInfo;
      
      public function CrossGuildMemberItem(param1:int, param2:int)
      {
         super();
         index = param1;
         showType = param2;
         initView();
      }
      
      private function initView() : void
      {
         _contributionText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildMemberItem.scoreText");
         _fightText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildMemberItem.fightText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildMemberItem.nameText");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildMemberItem.rankText");
         _fightImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildMemberItem.fightImage");
         _line = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildMemberItem.line");
         _profileImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuildMemberItem.profileImage");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("CrossGuildMemberItem.skillIcon");
         _heroIcon = ComponentFactory.Instance.creatCustomObject("CrossGuildMemberItem.heroIcon");
         addChild(_rankText);
         addChild(_heroIcon);
         addChild(_nameText);
         addChild(_fightImage);
         addChild(_fightText);
         addChild(_contributionText);
         addChild(_skillIcon);
         addChild(_profileImage);
         _profileImage.mouseEnabled = false;
         addChild(_line);
      }
      
      public function get data() : CrossGuildMemberInfo
      {
         return _data;
      }
      
      public function set data(param1:CrossGuildMemberInfo) : void
      {
         var _loc2_:SkillTempInfo = null;
         _data = param1;
         clean();
         if(data)
         {
            _heroIcon.visible = true;
            _heroIcon.icon = IconFactory.getHeadIcon(data.headId,"smallhead",".jpg");
            _rankText.text = index + "";
            _nameText.text = data.nickName;
            _fightImage.visible = true;
            _line.visible = true;
            _fightText.text = data.fightCapacity + "";
            if(showType == 1)
            {
               _loc2_ = TempleteManager.instance.skillTemplateDic[data.bufferId];
               if(_loc2_)
               {
                  _profileImage.visible = true;
                  _skillIcon.visible = true;
                  _profileImage.setFrame(_loc2_.Grades - 1);
                  _skillIcon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
                  _skillIcon.tipData = _loc2_;
               }
            }
            else
            {
               _contributionText.text = data.contributionValue + "";
            }
            resetPosition();
         }
      }
      
      private function resetPosition() : void
      {
         if(showType == 1)
         {
            _rankText.x = 8;
            _rankText.y = 22;
            _heroIcon.x = 45;
            _heroIcon.y = 14;
            _nameText.x = 78;
            _nameText.y = 6;
            _fightImage.x = 79;
            _fightImage.y = 28;
            _fightText.x = 100;
            _fightText.y = 30;
            _line.scaleX = 1;
         }
         else
         {
            _rankText.x = 25;
            _rankText.y = 22;
            _heroIcon.x = 120;
            _heroIcon.y = 14;
            _nameText.x = 153;
            _nameText.y = 6;
            _fightImage.x = 154;
            _fightImage.y = 28;
            _fightText.x = 175;
            _fightText.y = 30;
            _line.scaleX = 1.9;
         }
      }
      
      private function clean() : void
      {
         _rankText.text = "";
         _nameText.text = "";
         _fightImage.visible = false;
         _fightText.text = "";
         _contributionText.text = "";
         _profileImage.visible = false;
         _skillIcon.visible = false;
         _line.visible = false;
         _heroIcon.visible = false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_contributionText);
         _contributionText = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_fightImage);
         _fightImage = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_profileImage);
         _profileImage = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_heroIcon);
         _heroIcon = null;
         super.dispose();
      }
   }
}

