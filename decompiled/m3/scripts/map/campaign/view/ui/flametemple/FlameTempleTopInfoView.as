package map.campaign.view.ui.flametemple
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.PvpWarFightInfo;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.CountDownView;
   import map.campaign.view.ui.DownTimeView;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class FlameTempleTopInfoView extends Sprite implements Disposeable
   {
      
      private var _mapModel:CampaignMapModel;
      
      private var _templeModel:PvpWarFightModel;
      
      private var _timeForStart:int;
      
      private var _timeForEnd:int;
      
      private var _bg:Bitmap;
      
      private var _blueLogo:Image;
      
      private var _blueScoreBar:MovieClip;
      
      private var _blueScoreLabel:Image;
      
      private var _blueScoreTxt:FilterFrameText;
      
      private var _blueTowerImage:Image;
      
      private var _blueTowerTxt:FilterFrameText;
      
      private var _blueFlameImage:Image;
      
      private var _blueX:Image;
      
      private var _blueFlameCountTxt:Component;
      
      private var _blueNumImg:CustomBitmap;
      
      private var _blueNumTxt:FilterFrameText;
      
      private var _redLogo:Image;
      
      private var _redScoreBar:MovieClip;
      
      private var _redScoreLabel:Image;
      
      private var _redScoreTxt:FilterFrameText;
      
      private var _redTowerImage:Image;
      
      private var _redTowerTxt:FilterFrameText;
      
      private var _redFlameImage:Image;
      
      private var _redX:Image;
      
      private var _redFlameCountTxt:Component;
      
      private var _redNumImg:CustomBitmap;
      
      private var _redNumTxt:FilterFrameText;
      
      private var _numberSheet:BitmapData;
      
      private var _blueTip:FlameTempleFlameInfoTip;
      
      private var _redTip:FlameTempleFlameInfoTip;
      
      private var _centerDownTime:CountDownView;
      
      private var _topDownTime:DownTimeView;
      
      private var _showBlueTip:Boolean;
      
      private var _showRedTip:Boolean;
      
      private var _blueFlameCount:int = 0;
      
      private var _redFlameCount:int = 0;
      
      public function FlameTempleTopInfoView()
      {
         super();
         _mapModel = CampaignManager.instance.mapModel;
         _templeModel = CampaignManager.instance.pvpWarFightModel;
         _timeForStart = getTimeStart();
         _timeForEnd = getTimeEnd();
         initView();
         addEvent();
         updateTime();
         update();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.flametemple.TopBottomImg");
         _blueLogo = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.blueLogo");
         _blueScoreBar = ComponentFactory.Instance.creatCustomObject("flametemple.BuleScoreBar");
         _blueScoreLabel = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.blueScoreLabel");
         _blueScoreTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.blueScoreTxt");
         _blueTowerImage = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.blueTowerImage");
         _blueTowerTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.blueTowerTxt");
         _blueFlameImage = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.blueFlameImage");
         _blueX = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.blueX");
         _blueFlameCountTxt = new Component();
         _blueNumImg = ComponentFactory.Instance.creatCustomObject("flametemple.blueNumImg");
         _blueNumTxt = ComponentFactory.Instance.creatComponentByStylename("flametemple.blueNumTxt");
         _redLogo = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.redLogo");
         _redScoreBar = ComponentFactory.Instance.creatCustomObject("flametemple.RedScoreBar");
         _redScoreLabel = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.redScoreLabel");
         _redScoreTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.redScoreTxt");
         _redTowerImage = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.redTowerImage");
         _redTowerTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.redTowerTxt");
         _redFlameImage = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.redFlameImage");
         _redX = ComponentFactory.Instance.creatComponentByStylename("flameTempleTopInfoView.redX");
         _redFlameCountTxt = new Component();
         _redNumImg = ComponentFactory.Instance.creatCustomObject("flametemple.redNumImg");
         _redNumTxt = ComponentFactory.Instance.creatComponentByStylename("flametemple.redNumTxt");
         addChild(_bg);
         addChild(_blueLogo);
         addChild(_blueScoreBar);
         addChild(_blueScoreLabel);
         addChild(_blueScoreTxt);
         addChild(_blueTowerImage);
         addChild(_blueTowerTxt);
         addChild(_blueFlameImage);
         addChild(_blueX);
         addChild(_blueFlameCountTxt);
         addChild(_blueNumImg);
         addChild(_blueNumTxt);
         addChild(_redLogo);
         addChild(_redScoreBar);
         addChild(_redScoreLabel);
         addChild(_redScoreTxt);
         addChild(_redTowerImage);
         addChild(_redTowerTxt);
         addChild(_redFlameImage);
         addChild(_redX);
         addChild(_redFlameCountTxt);
         addChild(_redNumImg);
         addChild(_redNumTxt);
         _blueTip = new FlameTempleFlameInfoTip(1);
         _redTip = new FlameTempleFlameInfoTip(2);
         _blueTip.x = -20;
         _redTip.x = 340;
         _blueTip.y = _redTip.y = 62;
         addChild(_blueTip);
         addChild(_redTip);
         _redScoreBar.scaleX = -1;
         _blueFlameCountTxt.x = 185;
         _blueFlameCountTxt.y = 131;
         _redFlameCountTxt.x = 310;
         _redFlameCountTxt.y = 131;
         _topDownTime = new DownTimeView(false);
         _topDownTime.x = 161;
         _topDownTime.y = -16;
         _numberSheet = ComponentFactory.Instance.creatBitmapData("worldboss.river.NumberAsset");
         NumberViewUtils.getNumberView(0,_blueFlameCountTxt,_numberSheet,20,23,13,20,"0123456789",1);
         NumberViewUtils.getNumberView(0,_redFlameCountTxt,_numberSheet,20,23,13,20,"0123456789",1);
         _blueScoreTxt.text = "0";
         _redScoreTxt.text = "0";
         _blueTowerTxt.text = "x0";
         _redTowerTxt.text = "x0";
         _blueTip.tipData = "";
         _redTip.tipData = "";
         _blueScoreBar.gotoAndStop(100);
         _redScoreBar.gotoAndStop(100);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_blueLogo);
         _blueLogo = null;
         ObjectUtils.disposeObject(_blueScoreBar);
         _blueScoreBar = null;
         ObjectUtils.disposeObject(_blueScoreLabel);
         _blueScoreLabel = null;
         ObjectUtils.disposeObject(_blueScoreTxt);
         _blueScoreTxt = null;
         ObjectUtils.disposeObject(_blueTowerImage);
         _blueTowerImage = null;
         ObjectUtils.disposeObject(_blueTowerTxt);
         _blueTowerTxt = null;
         ObjectUtils.disposeObject(_blueFlameImage);
         _blueFlameImage = null;
         ObjectUtils.disposeObject(_blueX);
         _blueX = null;
         ObjectUtils.disposeObject(_blueFlameCountTxt);
         _blueFlameCountTxt = null;
         ObjectUtils.disposeObject(_blueNumImg);
         _blueNumImg = null;
         ObjectUtils.disposeObject(_blueNumTxt);
         _blueNumTxt = null;
         ObjectUtils.disposeObject(_redLogo);
         _redLogo = null;
         ObjectUtils.disposeObject(_redScoreBar);
         _redScoreBar = null;
         ObjectUtils.disposeObject(_redScoreLabel);
         _redScoreLabel = null;
         ObjectUtils.disposeObject(_redScoreTxt);
         _redScoreTxt = null;
         ObjectUtils.disposeObject(_redTowerImage);
         _redTowerImage = null;
         ObjectUtils.disposeObject(_redTowerTxt);
         _redTowerTxt = null;
         ObjectUtils.disposeObject(_redFlameImage);
         _redFlameImage = null;
         ObjectUtils.disposeObject(_redX);
         _redX = null;
         ObjectUtils.disposeObject(_redFlameCountTxt);
         _redFlameCountTxt = null;
         ObjectUtils.disposeObject(_redNumImg);
         _redNumImg = null;
         ObjectUtils.disposeObject(_redNumTxt);
         _redNumTxt = null;
         ObjectUtils.disposeObject(_blueTip);
         _blueTip = null;
         ObjectUtils.disposeObject(_redTip);
         _redTip = null;
         ObjectUtils.disposeObject(_numberSheet);
         _numberSheet = null;
         ObjectUtils.disposeObject(_centerDownTime);
         _centerDownTime = null;
         ObjectUtils.disposeObject(_topDownTime);
         _topDownTime = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _mapModel.addEventListener("syncErrorTime",__syncErrorTimeHandler);
         _mapModel.addEventListener("opentimemv",__openTimeHandler);
         _mapModel.addEventListener("SYS_ARMY_UPDATE",__changeHandler);
         _templeModel.pvpWarFightInfo.addEventListener("PVP_WAR_FIGHT_INFO_CHAGE",__changeHandler);
         _blueFlameImage.addEventListener("rollOver",__rollOverFlameImageHandler);
         _blueFlameImage.addEventListener("rollOut",__rollOutFlameImageHandler);
         _redFlameImage.addEventListener("rollOver",__rollOverFlameImageHandler);
         _redFlameImage.addEventListener("rollOut",__rollOutFlameImageHandler);
      }
      
      private function removeEvent() : void
      {
         if(_mapModel)
         {
            _mapModel.removeEventListener("syncErrorTime",__syncErrorTimeHandler);
            _mapModel.removeEventListener("opentimemv",__openTimeHandler);
            _mapModel.removeEventListener("SYS_ARMY_UPDATE",__changeHandler);
         }
         if(_templeModel && _templeModel.pvpWarFightInfo)
         {
            _templeModel.pvpWarFightInfo.removeEventListener("PVP_WAR_FIGHT_INFO_CHAGE",__changeHandler);
         }
         if(_blueFlameImage)
         {
            _blueFlameImage.removeEventListener("rollOver",__rollOverFlameImageHandler);
            _blueFlameImage.removeEventListener("rollOut",__rollOutFlameImageHandler);
         }
         if(_redFlameImage)
         {
            _redFlameImage.removeEventListener("rollOver",__rollOverFlameImageHandler);
            _redFlameImage.removeEventListener("rollOut",__rollOutFlameImageHandler);
         }
      }
      
      private function __syncErrorTimeHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.pvpmap.PvpMapTopCenterView.vFlaushTime");
         MessageTipManager.instance().show(_loc2_ + ": " + CampaignManager.instance.mapModel.syncErrorTime);
         updateTime();
      }
      
      private function updateTime() : void
      {
         var _loc1_:int = getTimeStart();
         if(_loc1_ > 0)
         {
            if(_centerDownTime)
            {
               _centerDownTime.dispose();
            }
            _centerDownTime = new CountDownView(2);
            _centerDownTime.setData(_loc1_,0,openCallBack);
            _centerDownTime.show();
         }
         else
         {
            if(_topDownTime)
            {
               _topDownTime.count = getTimeEnd();
            }
            addChild(_topDownTime);
         }
      }
      
      public function __openTimeHandler(param1:CampaignMapEvent) : void
      {
         if(_centerDownTime)
         {
            _centerDownTime.dispose();
         }
         _centerDownTime = new CountDownView(2);
         addChild(_centerDownTime);
         _centerDownTime.setData(10,10,openCallBack);
         _centerDownTime.show();
      }
      
      private function openCallBack() : void
      {
         if(_topDownTime)
         {
            _topDownTime.count = getTimeEnd();
         }
         if(!contains(_topDownTime))
         {
            addChild(_topDownTime);
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         update();
      }
      
      private function getTimeStart() : Number
      {
         var _loc4_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:Number = _loc4_.time;
         var _loc5_:Array = [0,30];
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("CrossWar_Time");
         if(_loc2_ && _loc2_.ConfigValue)
         {
            _loc5_ = _loc2_.ConfigValue.split(",");
         }
         if(_loc4_.minutes > int(_loc5_[1]))
         {
            _loc4_.hours += 1;
         }
         _loc4_.minutes = int(_loc5_[0]) + 5;
         _loc4_.seconds = 0;
         return (_loc4_.time - _loc3_) * 0.001;
      }
      
      private function getTimeEnd() : Number
      {
         var _loc4_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:Number = _loc4_.time;
         var _loc5_:Array = [0,30];
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("CrossWar_Time");
         if(_loc2_ && _loc2_.ConfigValue)
         {
            _loc5_ = _loc2_.ConfigValue.split(",");
         }
         if(_loc4_.minutes > int(_loc5_[1]))
         {
            _loc4_.hours += 1;
         }
         _loc4_.minutes = int(_loc5_[1]);
         _loc4_.seconds = 0;
         return (_loc4_.time - _loc3_) * 0.001;
      }
      
      private function __rollOverFlameImageHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _blueFlameImage)
         {
            _blueTip.visible = _blueFlameCount > 0;
            _showBlueTip = true;
         }
         else if(param1.currentTarget == _redFlameImage)
         {
            _redTip.visible = _redFlameCount > 0;
            _showRedTip = true;
         }
      }
      
      private function __rollOutFlameImageHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _blueFlameImage)
         {
            _blueTip.visible = false;
            _showBlueTip = false;
         }
         else if(param1.currentTarget == _redFlameImage)
         {
            _redTip.visible = false;
            _showRedTip = false;
         }
      }
      
      public function update() : void
      {
         var _loc2_:PvpWarFightInfo = _templeModel.pvpWarFightInfo;
         var _loc5_:int = 1;
         var _loc4_:Array = _mapModel.getArmysByState(5);
         var _loc1_:Array = [];
         var _loc3_:Array = [];
         for each(var _loc6_:CampaignArmy in _loc4_)
         {
            if(_loc6_.online)
            {
               if(_loc6_.teamId == 1)
               {
                  _loc1_.push(_loc6_);
               }
               else if(_loc6_.teamId == 2)
               {
                  _loc3_.push(_loc6_);
               }
            }
         }
         _blueFlameCount = _loc1_.length;
         _redFlameCount = _loc3_.length;
         NumberViewUtils.getNumberView(_loc1_.length,_blueFlameCountTxt,_numberSheet,20,23,13,20,"0123456789",1);
         _blueScoreTxt.text = _loc2_.oneScore + "";
         _blueTowerTxt.text = "x" + _templeModel.blueEnergyGapCount;
         _blueTip.tipData = _loc1_;
         if(_showBlueTip)
         {
            _blueTip.visible = _blueFlameCount > 0;
         }
         else
         {
            _blueTip.visible = false;
         }
         _loc5_ = _loc2_.oneScore * 100 / 5000;
         if(_loc5_ <= 0)
         {
            _loc5_ = 1;
         }
         _blueScoreBar.gotoAndStop(_loc5_);
         _blueNumTxt.text = _loc2_.oneCount.toString();
         NumberViewUtils.getNumberView(_loc3_.length,_redFlameCountTxt,_numberSheet,20,23,13,20,"0123456789",1);
         _redScoreTxt.text = _loc2_.twoScore + "";
         _redTowerTxt.text = "x" + _templeModel.redEnergyGapCount;
         _redTip.tipData = _loc3_;
         if(_showRedTip)
         {
            _redTip.visible = _redFlameCount > 0;
         }
         else
         {
            _redTip.visible = false;
         }
         _loc5_ = _loc2_.twoScore * 100 / 5000;
         if(_loc5_ <= 0)
         {
            _loc5_ = 1;
         }
         _redScoreBar.gotoAndStop(_loc5_);
         _redNumTxt.text = _loc2_.twoCount.toString();
         _blueFlameImage.tipData = LanguageMgr.GetTranslation("flameTempleTopInfoView.flameImageTip" + _loc1_.length,LanguageMgr.GetTranslation("blueTeam"));
         _redFlameImage.tipData = LanguageMgr.GetTranslation("flameTempleTopInfoView.flameImageTip" + _loc3_.length,LanguageMgr.GetTranslation("redTeam"));
      }
      
      override public function get width() : Number
      {
         return 501;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uintView();
      }
   }
}

