package map.campaign.view.ui.pvpmap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.PvpWarFightInfo;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.CountDownView;
   import map.campaign.view.ui.DownTimeView;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PvpMapTopCenterView extends Sprite implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _redFlag:ScaleBitmapImage;
      
      private var _blueFlag:ScaleBitmapImage;
      
      private var _downTimeBitmap:Bitmap;
      
      private var _downTime:DownTimeView;
      
      private var _countDownTime:CountDownView;
      
      private var _redScoreTxt:FilterFrameText;
      
      private var _redCountTxt:FilterFrameText;
      
      private var _redPlayerTxt:FilterFrameText;
      
      private var _blueScoreTxt:FilterFrameText;
      
      private var _blueCountTxt:FilterFrameText;
      
      private var _bluePlayerTxt:FilterFrameText;
      
      private var _data:PvpWarFightInfo;
      
      private var _mapModel:CampaignMapModel = CampaignManager.instance.mapModel;
      
      public function PvpMapTopCenterView()
      {
         super();
         init();
         addEvent();
      }
      
      private function addEvent() : void
      {
         _mapModel.addEventListener("syncErrorTime",__syncErrorTimeHandler);
         _mapModel.addEventListener("opentimemv",__openTimeHandler);
      }
      
      private function __syncErrorTimeHandler(param1:CampaignMapEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.pvpmap.PvpMapTopCenterView.vFlaushTime");
         MessageTipManager.instance().show(_loc2_ + ": " + CampaignManager.instance.mapModel.syncErrorTime);
         updateTime();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.TopCenterViewBg");
         addChild(_bg);
         _redFlag = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.teamRed");
         addChild(_redFlag);
         _blueFlag = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.teamBlue");
         addChild(_blueFlag);
         _downTimeBitmap = ComponentFactory.Instance.creatBitmap("asset.campaign.pvp.DownTimeAsset");
         addChild(_downTimeBitmap);
         _downTime = new DownTimeView();
         _downTime.x = 90;
         _downTime.y = -23;
         _redScoreTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.RedValueTxt");
         addChild(_redScoreTxt);
         _blueScoreTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.BlueValueTxt");
         addChild(_blueScoreTxt);
         _redCountTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.TeamCountTxt");
         addChild(_redCountTxt);
         _redCountTxt.x = 140;
         _redCountTxt.y = 55;
         _redPlayerTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.TeamCountTxt");
         var _loc1_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.pvpmap.PvpMapTopCenterView.person");
         addChild(_redPlayerTxt);
         _redPlayerTxt.x = 183;
         _redPlayerTxt.y = 55;
         _redPlayerTxt.text = _loc1_;
         _blueCountTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.TeamCountTxt");
         addChild(_blueCountTxt);
         _blueCountTxt.x = 140;
         _blueCountTxt.y = 33;
         _bluePlayerTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.TeamCountTxt");
         addChild(_bluePlayerTxt);
         _bluePlayerTxt.x = 183;
         _bluePlayerTxt.y = 33;
         _bluePlayerTxt.text = _loc1_;
      }
      
      public function set data(param1:PvpWarFightInfo) : void
      {
         _data = param1;
         _blueScoreTxt.text = param1.oneScore + "";
         _redScoreTxt.text = param1.twoScore + "";
         _blueCountTxt.text = param1.oneCount + " / 15 ";
         _redCountTxt.text = param1.twoCount + " / 15 ";
         updateTime();
      }
      
      private function __openTimeHandler(param1:CampaignMapEvent) : void
      {
         disposeCountTime();
         _countDownTime = new CountDownView(2);
         addChild(_countDownTime);
         _countDownTime.setData(10,10,openCallBack);
         _countDownTime.show();
      }
      
      private function updateTime() : void
      {
         if(int(openTime) > 0)
         {
            disposeCountTime();
            _countDownTime = new CountDownView(2);
            addChild(_countDownTime);
            _countDownTime.setData(openTime,0,callBack);
            _countDownTime.show();
         }
         else
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
      
      public function dispose() : void
      {
         _mapModel.removeEventListener("syncErrorTime",__syncErrorTimeHandler);
         _mapModel.removeEventListener("opentimemv",__openTimeHandler);
         disposeCountTime();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_redFlag);
         _redFlag = null;
         ObjectUtils.disposeObject(_blueFlag);
         _blueFlag = null;
         ObjectUtils.disposeObject(_downTimeBitmap);
         _downTimeBitmap = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         ObjectUtils.disposeObject(_redScoreTxt);
         _redScoreTxt = null;
         ObjectUtils.disposeObject(_redCountTxt);
         _redCountTxt = null;
         if(_redPlayerTxt)
         {
            _redPlayerTxt.dispose();
         }
         _redPlayerTxt = null;
         ObjectUtils.disposeObject(_blueScoreTxt);
         _blueScoreTxt = null;
         ObjectUtils.disposeObject(_blueCountTxt);
         _blueCountTxt = null;
         if(_bluePlayerTxt)
         {
            _bluePlayerTxt.dispose();
         }
         _bluePlayerTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

