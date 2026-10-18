package map.campaign.view.ui.duskarea
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.TimerUtils;
   import yishi.utils.WorldBossHelper;
   
   public class DuskAreaInfoView extends Component
   {
      
      private static var CD_TIME_DEL:uint = 1;
      
      private var _bg:DisplayObject;
      
      private var _bg2:DisplayObject;
      
      private var _blueJifenBar:MovieClip;
      
      private var _redJifenBar:MovieClip;
      
      private var _textCountDown:FilterFrameText;
      
      private var _textBlue:FilterFrameText;
      
      private var _textRed:FilterFrameText;
      
      private var _textBluePeople:FilterFrameText;
      
      private var _textRedPeople:FilterFrameText;
      
      private var _buildNumBlue:FilterFrameText;
      
      private var _buildNumRed:FilterFrameText;
      
      private var _cdTimeTxt:FilterFrameText;
      
      private var _readScore:int = 0;
      
      private var _blueScore:int = 0;
      
      private var _cdTimeUintFlag:uint;
      
      protected var queue:Vector.<MovieClip>;
      
      protected var pos:int;
      
      protected var dieFilter:UIFilter;
      
      protected var numBitmapData2:BitmapData;
      
      private var openTime:int;
      
      private var _cdFlagTimeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var cD_Timr:uint = 0;
      
      private var _isCdOpenTime:Boolean = true;
      
      protected var _data:CampaignArmy;
      
      public function DuskAreaInfoView()
      {
         this.width = 513;
         this.height = 70;
         super();
         initUI();
         _data = CampaignManager.instance.mapModel.selfMemberData;
         initView();
         initEvent();
         if(WorldBossHelper.checkDuskArea(mapModel.mapId))
         {
            onMapNode();
         }
         onTimer(null);
      }
      
      private function initUI() : void
      {
         numBitmapData2 = ComponentFactory.Instance.creatBitmapData("asset.core.PawnLevelNum_1");
         queue = new Vector.<MovieClip>();
         pos = 0;
         _bg = ComponentFactory.Instance.creatCustomObject("duskarea.duskareainfoview.bg");
         _bg2 = ComponentFactory.Instance.creatCustomObject("duskarea.duskareainfoview.bg2");
         _blueJifenBar = ComponentFactory.Instance.creatCustomObject("duskarea.duskareainfoview.blueBar") as MovieClip;
         _blueJifenBar.lightMc.visible = false;
         _blueJifenBar.lightMc.stop();
         _blueJifenBar.y = 12;
         if(WorldBossHelper.checkDuskArea(mapModel.mapId))
         {
            this.addChild(_bg2);
         }
         else
         {
            this.addChild(_bg);
         }
         this.addChild(_blueJifenBar);
         _redJifenBar = ComponentFactory.Instance.creatCustomObject("duskarea.duskareainfoview.redBar") as MovieClip;
         _redJifenBar.lightMc.visible = false;
         _redJifenBar.lightMc.stop();
         this.addChild(_redJifenBar);
         _textBlue = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.blueJifen");
         this.addChild(_textBlue);
         _blueJifenBar.maskSlide.scaleX = _redJifenBar.maskSlide.scaleX = 0;
         _textRed = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.redJifen");
         this.addChild(_textRed);
         _textBluePeople = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.bluepeople");
         this.addChild(_textBluePeople);
         _textRedPeople = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.redpeople");
         addChild(_textRedPeople);
         _buildNumBlue = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.bluebuildNum");
         addChild(_buildNumBlue);
         _buildNumRed = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.redbuildNum");
         addChild(_buildNumRed);
         _cdTimeTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.LeftTimeTxt");
         addChild(_cdTimeTxt);
         _cdFlagTimeTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.duskareainfoview.LeftTimeTxt1");
         addChild(_cdFlagTimeTxt);
         _cdFlagTimeTxt.text = "";
         resetPosition();
         _timer = new Timer(CD_TIME_DEL * 1000);
      }
      
      private function resetPosition() : void
      {
         if(WorldBossHelper.checkDuskArea(mapModel.mapId))
         {
            _redJifenBar.scaleX = -1;
            _blueJifenBar.scaleX = 1;
            _blueJifenBar.x = 79;
            _redJifenBar.x = 474;
            _textBlue.x = 180;
            _textBluePeople.x = 124;
            _textRed.x = 383;
            _textRedPeople.x = 464;
            _buildNumBlue.x = 237;
            _buildNumRed.x = 320;
         }
         else
         {
            _redJifenBar.scaleX = 1;
            _blueJifenBar.scaleX = -1;
            _blueJifenBar.x = 474;
            _redJifenBar.x = 79;
            _textBlue.x = 383;
            _textBluePeople.x = 464;
            _textRed.x = 180;
            _textRedPeople.x = 124;
            _buildNumBlue.x = 320;
            _buildNumRed.x = 237;
         }
      }
      
      private function initView() : void
      {
         _cdTimeTxt.text = "00:00";
         clearInterval(_cdTimeUintFlag);
         openTime = getTimeStart();
         if(openTime >= 0)
         {
            _isCdOpenTime = true;
            _cdTimeUintFlag = setInterval(cdTime,1000);
         }
         else
         {
            openTime = getTimeEnd();
            _cdTimeUintFlag = setInterval(cdTime,1000);
         }
      }
      
      private function initEvent() : void
      {
         pvpWarFightModel.pvpWarFightInfo.addEventListener("PVP_WAR_FIGHT_INFO_CHAGE",updateView);
         mapModel.addEventListener("currentNpcPos",onMapNode);
         mapModel.addEventListener("UPDATE_CAMPAING_NODE",onMapNode);
         NotificationManager.instance.addEventListener("UPDATE_TIMEENDFLAG",teamChange);
         _timer.addEventListener("timer",onTimer);
         _data.addEventListener("IS_DIE",__isDieHandler);
      }
      
      private function removeEvent() : void
      {
         pvpWarFightModel.pvpWarFightInfo.removeEventListener("PVP_WAR_FIGHT_INFO_CHAGE",updateView);
         mapModel.removeEventListener("currentNpcPos",onMapNode);
         mapModel.removeEventListener("UPDATE_CAMPAING_NODE",onMapNode);
         NotificationManager.instance.removeEventListener("UPDATE_TIMEENDFLAG",teamChange);
         _timer.removeEventListener("timer",onTimer);
         _data.addEventListener("IS_DIE",__isDieHandler);
      }
      
      protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         onTimer(null);
      }
      
      private function teamChange(param1:NotificationEvent) : void
      {
         onTimer(null);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         if(!pvpWarFightModel.time)
         {
            return;
         }
         var _loc3_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc2_:Number = _loc3_.time;
         var _loc4_:Number = (TimerUtils.convertToTimestamp(pvpWarFightModel.time) - _loc2_) / 1000;
         _timer.start();
         _cdFlagTimeTxt.text = LanguageMgr.GetTranslation("DuskAreaInfoView.enftimeflag") + _loc4_;
         if(_loc4_ <= 0 || !pvpWarFightModel.isFlag)
         {
            _cdFlagTimeTxt.text = "";
            _timer.stop();
         }
      }
      
      private function onMapNode(param1:* = null) : void
      {
         var _loc5_:int = 0;
         var _loc2_:CampaignNode = null;
         if(!WorldBossHelper.checkDuskArea(mapModel.mapId))
         {
            return;
         }
         var _loc4_:Array = mapModel.mapNodesData;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc5_];
            if(_loc2_.param2 == 5)
            {
               if(_loc2_.param1 == 1)
               {
                  _loc3_ += 1;
               }
               else if(_loc2_.param1 == 2)
               {
                  _loc6_ += 1;
               }
            }
            _loc5_++;
         }
         _buildNumBlue.text = "x " + _loc3_;
         _buildNumRed.text = "x " + _loc6_;
      }
      
      public function updateView(param1:Event = null) : void
      {
         if(_blueScore != pvpWarFightModel.pvpWarFightInfo.oneScore)
         {
            _blueJifenBar.lightMc.visible = true;
            _blueJifenBar.lightMc.gotoAndPlay(1);
            _blueJifenBar.lightMc.x = _blueJifenBar.width * _blueJifenBar.maskSlide.scaleX;
            playScoreMovie(pvpWarFightModel.pvpWarFightInfo.oneScore - _blueScore,new Point(_blueJifenBar.x,_blueJifenBar.y - 20));
         }
         if(_readScore != pvpWarFightModel.pvpWarFightInfo.twoScore)
         {
            _redJifenBar.lightMc.visible = true;
            _redJifenBar.lightMc.gotoAndPlay(1);
            _redJifenBar.lightMc.x = _redJifenBar.width * _redJifenBar.maskSlide.scaleX;
            playScoreMovie(pvpWarFightModel.pvpWarFightInfo.twoScore - _readScore,new Point(_redJifenBar.x - 90,_redJifenBar.y - 20));
         }
         _readScore = pvpWarFightModel.pvpWarFightInfo.twoScore;
         _blueScore = pvpWarFightModel.pvpWarFightInfo.oneScore;
         _textBlue.text = pvpWarFightModel.pvpWarFightInfo.oneScore.toString();
         _textRed.text = pvpWarFightModel.pvpWarFightInfo.twoScore.toString();
         _textBluePeople.text = pvpWarFightModel.pvpWarFightInfo.oneCount.toString();
         _textRedPeople.text = pvpWarFightModel.pvpWarFightInfo.twoCount.toString();
         _blueJifenBar.maskSlide.scaleX = pvpWarFightModel.pvpWarFightInfo.oneScore / 5000;
         _redJifenBar.maskSlide.scaleX = pvpWarFightModel.pvpWarFightInfo.twoScore / 5000;
         if(WorldBossHelper.checkIceFireTemple(mapModel.mapId))
         {
            _buildNumBlue.text = "x " + pvpWarFightModel.pvpWarFightInfo.buleFlagCount;
            _buildNumRed.text = "x " + pvpWarFightModel.pvpWarFightInfo.redFlagCount;
         }
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
      
      protected function playScoreMovie(param1:int, param2:Point) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc3_:MovieClip = movieClip;
         addChild(_loc3_);
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         var _loc4_:int = Math.abs(param1);
         NumberViewUtils.refreshValue(_loc4_,_loc3_["mv"]["pos"],numBitmapData2,19,25,15,19,"0123456789");
         if(!dieFilter)
         {
            dieFilter = new UIFilter();
         }
         if(param1 < 0)
         {
            dieFilter.setGrayFilter(_loc3_["mv"]["pos"]);
            _loc3_["mv"]["stateMc"].gotoAndStop(2);
         }
         else
         {
            dieFilter.setNormalFilter(_loc3_["mv"]["pos"]);
            _loc3_["mv"]["stateMc"].gotoAndStop(1);
         }
         _loc3_.mv.typeMc.gotoAndStop(1);
         _loc3_.gotoAndPlay(2);
         _loc3_ = null;
      }
      
      private function cdTime() : void
      {
         if(_cdTimeTxt == null)
         {
            return;
         }
         openTime -= 1;
         _cdTimeTxt.text = DateFormatter.getCountDateByMS(openTime);
         if(openTime < 0)
         {
            if(_isCdOpenTime)
            {
               clearInterval(_cdTimeUintFlag);
               openTime = getTimeEnd();
               _cdTimeUintFlag = setInterval(cdTime,1000);
               _isCdOpenTime = false;
            }
            else
            {
               _cdTimeTxt.text = "00:00";
               clearInterval(_cdTimeUintFlag);
            }
         }
      }
      
      private function get movieClip() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(queue.length < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("duskarea.UpdateScoreAsset");
            queue.push(_loc1_);
            return _loc1_;
         }
         if(pos == queue.length)
         {
            pos = 0;
         }
         return queue[pos++];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false,0,3);
      }
      
      private function get pvpWarFightModel() : PvpWarFightModel
      {
         return CampaignManager.instance.pvpWarFightModel;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearInterval(_cdTimeUintFlag);
         for each(var _loc1_:MovieClip in queue)
         {
            _loc1_.stop();
            ObjectUtils.disposeViolentMc(_loc1_);
            _loc1_.parent && _loc1_.parent.removeChild(_loc1_);
         }
         queue = null;
         dieFilter = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_blueJifenBar);
         _blueJifenBar = null;
         ObjectUtils.disposeObject(_redJifenBar);
         _redJifenBar = null;
         ObjectUtils.disposeObject(_textBlue);
         _textBlue = null;
         ObjectUtils.disposeObject(_textRed);
         _textRed = null;
         ObjectUtils.disposeObject(_cdTimeTxt);
         _cdTimeTxt = null;
         ObjectUtils.disposeObject(_textBluePeople);
         _textBluePeople = null;
         ObjectUtils.disposeObject(_textRedPeople);
         _textRedPeople = null;
         ObjectUtils.disposeObject(_buildNumBlue);
         _buildNumBlue = null;
         ObjectUtils.disposeObject(_buildNumRed);
         _buildNumRed = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

