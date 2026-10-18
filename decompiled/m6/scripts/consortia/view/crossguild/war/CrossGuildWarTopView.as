package consortia.view.crossguild.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   
   public class CrossGuildWarTopView extends Component
   {
      
      private var _redScrore:FilterFrameText;
      
      private var _greenScore:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _redGuildName:GradientText;
      
      private var _greenGuildName:GradientText;
      
      private var _topBack:Image;
      
      private var _greenBar:CrossGuildWarScoreProgressView;
      
      private var _redBar:CrossGuildWarScoreProgressView;
      
      private var _bufferBg:Image;
      
      private var _bufferTitle:Image;
      
      private var _bufferDescImage:Image;
      
      private var _bufferCountImage:Image;
      
      private var _number1Bmp:BitmapData;
      
      private var _number2Bmp:BitmapData;
      
      private var _number3Bmp:BitmapData;
      
      private var _totalCountBmp:BitmapData;
      
      private var _numberSprite:Sprite;
      
      private var _totalCountSprite:Sprite;
      
      private var _totalCount:int;
      
      private var _endDate:Date;
      
      private var _fightHoursTxt:FilterFrameText;
      
      public function CrossGuildWarTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _redScrore = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.redScrore");
         _greenScore = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.greenScore");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.timeText");
         _redGuildName = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTopView.redGuildName");
         _greenGuildName = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTopView.greenGuildName");
         _topBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.topBack");
         _greenBar = ComponentFactory.Instance.creatCustomObject("CrossGuildWarTopView.greenBar");
         _redBar = ComponentFactory.Instance.creatCustomObject("CrossGuildWarTopView.redBar");
         _bufferBg = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.bufferBg");
         _bufferTitle = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.bufferTitle");
         _bufferDescImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.bufferDescImage");
         _bufferCountImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.bufferCountImage");
         _number1Bmp = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildWarTopView.bufferNumber1");
         _number2Bmp = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildWarTopView.bufferNumber2");
         _number3Bmp = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildWarTopView.bufferNumber3");
         _totalCountBmp = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildWarTopView.totalCount");
         _fightHoursTxt = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarTopView.fightHoursTxt");
         _numberSprite = new Sprite();
         _totalCountSprite = new Sprite();
         _numberSprite.x = 768;
         _numberSprite.y = 45;
         _totalCountSprite.x = 805;
         _totalCountSprite.y = 48;
         addChild(_topBack);
         addChild(_greenBar);
         addChild(_redBar);
         addChild(_greenGuildName);
         addChild(_greenScore);
         addChild(_redGuildName);
         addChild(_redScrore);
         addChild(_timeText);
         _timeText.text = "00:00:00";
         addChild(_bufferBg);
         addChild(_bufferTitle);
         addChild(_bufferDescImage);
         addChild(_bufferCountImage);
         addChild(_numberSprite);
         addChild(_totalCountSprite);
         addChild(_fightHoursTxt);
         var _loc1_:String = ConfigInfoManager.instance.getConsortiaWarAttackBuffConfig();
         if(!StringHelper.isNullOrEmpty(_loc1_))
         {
            _totalCount = _loc1_.split(",")[1];
         }
         NumberViewUtils.refreshValue(_totalCount,_totalCountSprite,_totalCountBmp,14,18,10,14,"0123456789");
         refreshBufferCount();
         _bufferDescImage.tipData = LanguageMgr.GetTranslation("consortia.view.crossguild.war.bufferDescImageTxt");
      }
      
      private function addEvent() : void
      {
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function removeEvent() : void
      {
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function __updateTimeHandler(param1:PlayerEvent) : void
      {
         if(model.state == 6)
         {
            updateWarLeftTime();
         }
      }
      
      public function refreshView() : void
      {
         if(!model.myTeam || !model.vsTeam)
         {
            return;
         }
         if(model.myTeamId == 0)
         {
            _greenGuildName.text = model.vsTeam.consortiaName;
            _redGuildName.text = model.myTeam.consortiaName;
            _greenScore.text = LanguageMgr.GetTranslation("CrossGuildWarTopView.scoreText.text",model.vsTeam.blood,model.vsTeam.maxBlood);
            _redScrore.text = LanguageMgr.GetTranslation("CrossGuildWarTopView.scoreText.text",model.myTeam.blood,model.myTeam.maxBlood);
            _greenBar.refreshView(model.vsTeam.blood,model.vsTeam.maxBlood);
            _redBar.refreshView(model.myTeam.blood,model.myTeam.maxBlood);
         }
         else
         {
            _greenGuildName.text = model.myTeam.consortiaName;
            _redGuildName.text = model.vsTeam.consortiaName;
            _greenScore.text = LanguageMgr.GetTranslation("CrossGuildWarTopView.scoreText.text",model.myTeam.blood,model.myTeam.maxBlood);
            _redScrore.text = LanguageMgr.GetTranslation("CrossGuildWarTopView.scoreText.text",model.vsTeam.blood,model.vsTeam.maxBlood);
            _greenBar.refreshView(model.myTeam.blood,model.myTeam.maxBlood);
            _redBar.refreshView(model.vsTeam.blood,model.vsTeam.maxBlood);
         }
         refreshBufferCount();
         updateWarLeftTime();
      }
      
      private function refreshBufferCount() : void
      {
         var _loc1_:int = _totalCount - model.bufferCount;
         if(_loc1_ <= _totalCount / 3)
         {
            NumberViewUtils.refreshValue(_loc1_,_numberSprite,_number1Bmp,16,21,12,16,"0123456789");
         }
         else if(_loc1_ > _totalCount / 3 && _loc1_ <= _totalCount * 2 / 3)
         {
            NumberViewUtils.refreshValue(_loc1_,_numberSprite,_number2Bmp,16,21,12,16,"0123456789");
         }
         else
         {
            NumberViewUtils.refreshValue(_loc1_,_numberSprite,_number3Bmp,16,21,12,16,"0123456789");
         }
         if(_loc1_ >= 100)
         {
            _numberSprite.x = 758;
         }
         else if(_loc1_ < 100 && _loc1_ >= 10)
         {
            _numberSprite.x = 768;
         }
         else
         {
            _numberSprite.x = 778;
         }
      }
      
      private function updateWarLeftTime() : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = int(playerModel.sysCurtime.hours);
         var _loc1_:int = int(playerModel.sysCurtime.minutes);
         var _loc5_:int = playerModel.sysCurtime.hours * 60 + playerModel.sysCurtime.minutes;
         var _loc3_:int = model.consortiaWarFightStartHours * 60 + model.consortiaWarFightStartMin;
         var _loc4_:int = model.consortiaWarFightEndHours * 60 + model.consortiaWarFightEndMin;
         if(_loc5_ >= _loc3_ && _loc5_ < _loc4_)
         {
            if(!_endDate)
            {
               _endDate = new Date(playerModel.sysCurtime.fullYear,playerModel.sysCurtime.month,playerModel.sysCurtime.date);
               _endDate.hours = model.consortiaWarFightEndHours;
               _endDate.minutes = model.consortiaWarFightEndMin;
            }
            _loc6_ = (_endDate.time - playerModel.sysCurtime.time) / 1000;
            _timeText.text = DateFormatter.getConsortiaCountDate(_loc6_);
            _fightHoursTxt.visible = false;
         }
         else
         {
            _fightHoursTxt.visible = true;
            _fightHoursTxt.text = LanguageMgr.GetTranslation("consortia.view.crossguild.war.fightHoursTxt");
            _timeText.text = model.consortiaWarFightOpenStr + "--" + model.consortiaWarFightEndStr;
         }
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_redScrore);
         _redScrore = null;
         ObjectUtils.disposeObject(_greenScore);
         _greenScore = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_redGuildName);
         _redGuildName = null;
         ObjectUtils.disposeObject(_greenGuildName);
         _greenGuildName = null;
         ObjectUtils.disposeObject(_topBack);
         _topBack = null;
         ObjectUtils.disposeObject(_greenBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_redBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_number1Bmp);
         _number1Bmp = null;
         ObjectUtils.disposeObject(_number2Bmp);
         _number2Bmp = null;
         ObjectUtils.disposeObject(_number3Bmp);
         _number3Bmp = null;
         ObjectUtils.disposeObject(_totalCountBmp);
         _totalCountBmp = null;
         ObjectUtils.disposeObject(_numberSprite);
         _numberSprite = null;
         ObjectUtils.disposeObject(_totalCountSprite);
         _totalCountSprite = null;
         ObjectUtils.disposeObject(_bufferBg);
         _bufferBg = null;
         ObjectUtils.disposeObject(_bufferTitle);
         _bufferTitle = null;
         ObjectUtils.disposeObject(_bufferDescImage);
         _bufferDescImage = null;
         super.dispose();
      }
   }
}

