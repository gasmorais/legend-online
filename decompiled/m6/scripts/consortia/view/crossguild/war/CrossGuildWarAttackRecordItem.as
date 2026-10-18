package consortia.view.crossguild.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import mvc.module.crossguild.CrossGuildRecordInfo;
   import yishi.manager.CrossGuildManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class CrossGuildWarAttackRecordItem extends Component
   {
      
      private var _toubleText:FilterFrameText;
      
      private var _fortifiedAttackText:FilterFrameText;
      
      private var _attackText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _fightText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _rankText:FilterFrameText;
      
      private var _line:Image;
      
      private var _heroIcon:BaseIconView;
      
      private var _fightImage:Image;
      
      private var _data:CrossGuildRecordInfo;
      
      private var rankIndex:int;
      
      public function CrossGuildWarAttackRecordItem(param1:int)
      {
         super();
         rankIndex = param1;
         initView();
      }
      
      private function initView() : void
      {
         _toubleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.toubleText");
         _fortifiedAttackText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.fortifiedAttackText");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.attackText");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.scoreText");
         _fightText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.fightText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.nameText");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.rankText");
         _line = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarAttackRecordItem.line");
         _fightImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarAttackRecordItem.fightImage");
         _heroIcon = ComponentFactory.Instance.creatCustomObject("CrossGuildWarAttackRecordItem.heroIcon");
         addChild(_rankText);
         addChild(_nameText);
         addChild(_fightImage);
         addChild(_fightText);
         addChild(_attackText);
         addChild(_fortifiedAttackText);
         addChild(_toubleText);
         addChild(_scoreText);
         addChild(_line);
      }
      
      public function set side(param1:int) : void
      {
         if(param1 == 0)
         {
            if(model.myTeamId == 0)
            {
               _nameText.setFrame(1);
               _fightText.setFrame(1);
            }
            else
            {
               _nameText.setFrame(2);
               _fightText.setFrame(2);
            }
         }
         else if(model.myTeamId == 0)
         {
            _nameText.setFrame(2);
            _fightText.setFrame(2);
         }
         else
         {
            _nameText.setFrame(1);
            _fightText.setFrame(1);
         }
      }
      
      public function get data() : CrossGuildRecordInfo
      {
         return _data;
      }
      
      public function set data(param1:CrossGuildRecordInfo) : void
      {
         _data = param1;
         clean();
         if(data)
         {
            _heroIcon.visible = true;
            _fightImage.visible = true;
            _line.visible = true;
            _rankText.text = rankIndex + "";
            _heroIcon.icon = IconFactory.getHeadIcon(data.headId,"smallhead",".jpg");
            _nameText.text = data.nickName;
            _fightText.text = data.fightPower + "";
            _scoreText.text = data.totalScore + "";
            _attackText.htmlText = LanguageMgr.GetTranslation("CrossGuildWarAttackRecordItem.attackText.text",data.count1,data.score1);
            _fortifiedAttackText.htmlText = LanguageMgr.GetTranslation("CrossGuildWarAttackRecordItem.fortifiedAttackText.text",data.count2,data.score2);
            _toubleText.htmlText = LanguageMgr.GetTranslation("CrossGuildWarAttackRecordItem.toubleText.text",data.count3,data.score3);
         }
      }
      
      private function clean() : void
      {
         _rankText.text = "";
         _nameText.text = "";
         _heroIcon.visible = false;
         _fightImage.visible = false;
         _fightText.text = "";
         _attackText.text = "";
         _fortifiedAttackText.text = "";
         _toubleText.text = "";
         _scoreText.text = "";
         _line.visible = false;
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_toubleText);
         _toubleText = null;
         ObjectUtils.disposeObject(_fortifiedAttackText);
         _fortifiedAttackText = null;
         ObjectUtils.disposeObject(_attackText);
         _attackText = null;
         ObjectUtils.disposeObject(_scoreText);
         _scoreText = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_heroIcon);
         _heroIcon = null;
         ObjectUtils.disposeObject(_fightImage);
         _fightImage = null;
         super.dispose();
      }
   }
}

