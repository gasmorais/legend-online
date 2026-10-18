package map.campaign.view.ui.svsmap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.SvsCampaignInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.CountDownView;
   import map.campaign.view.ui.DownTimeView;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SvsCampaignInfoView extends Sprite implements Disposeable
   {
      
      private var _bg:MovieClip;
      
      private var _downTime:DownTimeView;
      
      private var _countDownTime:CountDownView;
      
      private var _winner:ScaleFrameImage;
      
      private var _blueScoreBar:MovieClip;
      
      private var _blueCountTxt:FilterFrameText;
      
      private var _blueNameTxt:FilterFrameText;
      
      private var _redScoreBar:MovieClip;
      
      private var _redCountTxt:FilterFrameText;
      
      private var _redNameTxt:FilterFrameText;
      
      private var _data:SvsCampaignInfo;
      
      private var _mapModel:CampaignMapModel = CampaignManager.instance.mapModel;
      
      public function SvsCampaignInfoView()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatCustomObject("svsmap.svsTopBg");
         _winner = ComponentFactory.Instance.creatComponentByStylename("svsmap.Winner");
         _blueScoreBar = ComponentFactory.Instance.creatCustomObject("svsmap.BuleScoreBar");
         _blueCountTxt = ComponentFactory.Instance.creatComponentByStylename("svsmap.BlueCountTxt");
         _blueNameTxt = ComponentFactory.Instance.creatComponentByStylename("svsmap.BlueNameTxt");
         _redScoreBar = ComponentFactory.Instance.creatCustomObject("svsmap.RedScoreBar");
         _redCountTxt = ComponentFactory.Instance.creatComponentByStylename("svsmap.RedCountTxt");
         _redNameTxt = ComponentFactory.Instance.creatComponentByStylename("svsmap.RedNameTxt");
         _downTime = new DownTimeView(false);
         _downTime.x = 140;
         _downTime.y = 8;
         _blueScoreBar.scaleX = -1;
         _bg["content"].addChild(_blueScoreBar);
         _bg["content"].addChild(_redScoreBar);
         addChild(_bg);
         addChild(_winner);
         addChild(_blueCountTxt);
         addChild(_blueNameTxt);
         addChild(_redCountTxt);
         addChild(_redNameTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         ObjectUtils.disposeObject(_redCountTxt);
         _redCountTxt = null;
         ObjectUtils.disposeObject(_blueCountTxt);
         _blueCountTxt = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
         _mapModel.addEventListener("syncErrorTime",__syncErrorTimeHandler);
         _mapModel.addEventListener("opentimemv",__openTimeHandler);
      }
      
      private function removeEvent() : void
      {
         _mapModel.removeEventListener("syncErrorTime",__syncErrorTimeHandler);
         _mapModel.removeEventListener("opentimemv",__openTimeHandler);
      }
      
      private function __syncErrorTimeHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.pvpmap.PvpMapTopCenterView.vFlaushTime");
         MessageTipManager.instance().show(_loc2_ + ": " + CampaignManager.instance.mapModel.syncErrorTime);
         updateTime();
      }
      
      private function __openTimeHandler(param1:CampaignMapEvent) : void
      {
      }
      
      private function updateTime() : void
      {
         if(int(openTime) <= 0)
         {
            if(_downTime)
            {
               _downTime.count = offTime;
            }
            addChild(_downTime);
         }
      }
      
      private function get openTime() : Number
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
      
      private function get offTime() : Number
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
      
      private function callBack() : void
      {
         if(_downTime)
         {
            _downTime.count = 1500;
            _downTime.stop();
         }
         if(!contains(_downTime))
         {
            addChild(_downTime);
         }
      }
      
      private function openCallBack() : void
      {
         if(_downTime)
         {
            _downTime.count = offTime;
         }
         if(!contains(_downTime))
         {
            addChild(_downTime);
         }
      }
      
      private function disposeCountTime() : void
      {
         if(_countDownTime)
         {
            _countDownTime.dispose();
            if(_countDownTime.parent)
            {
               _countDownTime.parent.removeChild(_countDownTime);
            }
            _countDownTime = null;
         }
      }
      
      public function set data(param1:SvsCampaignInfo) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         _data = param1;
         var _loc7_:int = int(_data.liveCount1);
         var _loc4_:int = int(_data.totalCount1);
         var _loc5_:int = int(_data.liveCount2);
         var _loc3_:int = int(_data.totalCount2);
         if(_loc7_ == 0 && _loc5_ == 0)
         {
            _loc6_ = 1;
            _loc2_ = 1;
         }
         else
         {
            _loc6_ = _loc7_ * 100 / 40;
            _loc2_ = _loc5_ * 100 / 40;
         }
         if(_loc6_ == 0)
         {
            _loc6_ = 1;
         }
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         _blueScoreBar.gotoAndStop(_loc6_);
         _blueCountTxt.text = _loc7_ + "/" + _loc4_;
         _blueNameTxt.text = _data.site1;
         _redScoreBar.gotoAndStop(_loc2_);
         _redCountTxt.text = _loc5_ + "/" + _loc3_;
         _redNameTxt.text = _data.site2;
         _winner.setFrame(1);
         _winner.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.svsmap.SvsCampaignInfoView.TipsTxt01");
         if(_loc6_ > _loc2_)
         {
            _winner.setFrame(2);
            _winner.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.svsmap.SvsCampaignInfoView.TipsTxt02");
         }
         else if(_loc6_ < _loc2_)
         {
            _winner.setFrame(3);
            _winner.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.svsmap.SvsCampaignInfoView.TipsTxt03");
         }
         updateTime();
      }
      
      public function dispose() : void
      {
         removeEvent();
         disposeCountTime();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

