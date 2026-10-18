package managers
{
   import com.road.yishi.proto.campaign.CampaignSweepReq;
   import com.road.yishi.proto.campaign.CampaignSweepRsp;
   import flash.events.EventDispatcher;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.mopup.MopupModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MopupManager extends EventDispatcher
   {
      
      private static var _instance:MopupManager;
      
      private var _model:MopupModel;
      
      public function MopupManager()
      {
         super();
         setup();
      }
      
      public static function get instance() : MopupManager
      {
         if(!_instance)
         {
            _instance = new MopupManager();
         }
         return _instance;
      }
      
      public function get model() : MopupModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new MopupModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4425,__refreshMopupInfoHandler);
      }
      
      private function __refreshMopupInfoHandler(param1:SLGSocketEvent) : void
      {
         var pkg:PackageIn;
         var msg:CampaignSweepRsp;
         var i:int;
         var k:int;
         var j:int;
         var mopupTipData:String;
         var id:int;
         var e:SLGSocketEvent = param1;
         model.beginChanges();
         pkg = e.data as PackageIn;
         msg = new CampaignSweepRsp();
         msg = pkg.readBody(msg) as CampaignSweepRsp;
         if(msg.hasCampaignId)
         {
            model.campaignId = msg.campaignId;
         }
         if(msg.dropItems)
         {
            model.mopupGoods = msg.dropItems;
         }
         if(msg.result.length > 0)
         {
            model.resultInfoList = [];
            i = 0;
            while(i < msg.result.length)
            {
               if(msg.result[i])
               {
                  model.resultInfoList.push(msg.result[i]);
               }
               if(msg.result[i].time)
               {
                  model.mopupRemainTime = msg.result[i].time;
               }
               if(msg.result[i].gp)
               {
                  model.mopupExt += msg.result[i].gp;
               }
               if(model.mopupGoods && model.mopupGoods.length > 0)
               {
                  k = 0;
                  while(k < msg.result[i].items.length)
                  {
                     j = 0;
                     while(j < model.mopupGoods.length)
                     {
                        if(msg.result[i].items[k].templateId == model.mopupGoods[j].templateId)
                        {
                           model.mopupGoods[j].count -= msg.result[i].items[k].count;
                           if(model.mopupGoods[j].count <= 0)
                           {
                              model.mopupGoods.splice(j,1);
                              j = j - 1;
                           }
                        }
                        j = j + 1;
                     }
                     k = k + 1;
                  }
               }
               i = i + 1;
            }
         }
         if(msg.status)
         {
            mopupTipData = "";
            switch(msg.status - 1)
            {
               case 0:
                  if(LitteActionManager.Instance.isOpen)
                  {
                     if(msg.sweepType == 2)
                     {
                        NotificationManager.instance.sendNotification("LITTLESECRETARY");
                     }
                     break;
                  }
                  if(msg.sweepType == 1)
                  {
                     FrameControllerManager.instance.openControllerByInfo("mopup",2);
                  }
                  else if(msg.sweepType == 2)
                  {
                     FrameControllerManager.instance.openControllerByInfo("mopup",4);
                  }
                  else if(msg.sweepType == 3)
                  {
                     FrameControllerManager.instance.openControllerByInfo("mopup",12);
                  }
                  else if(msg.sweepType == 4)
                  {
                     FrameControllerManager.instance.openControllerByInfo("mopup",14);
                  }
                  else if(msg.sweepType == 5)
                  {
                     FrameControllerManager.instance.openControllerByInfo("mopup",16);
                  }
                  else if(msg.sweepType == 6)
                  {
                     FrameControllerManager.instance.openControllerByInfo("mopup",20);
                  }
                  break;
               case 1:
                  mopupTipData = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
                  MessageTipManager.instance().show(mopupTipData);
                  break;
               case 2:
                  mopupTipData = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData02");
                  MessageTipManager.instance().show(mopupTipData);
                  break;
               case 3:
                  RechargeAlertMannager.show();
                  break;
               case 5:
                  mopupTipData = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData03");
                  MessageTipManager.instance().show(mopupTipData);
                  break;
               case 6:
                  break;
               case 9:
                  model.mopupExt = msg.totalGp;
                  model.mopupEnd = true;
                  if(msg.result && msg.result.length > 0)
                  {
                     if(msg.result[msg.result.length - 1].type == 1)
                     {
                        model.mopupEnd = true;
                     }
                     else if(msg.result[msg.result.length - 1].type == 2)
                     {
                        model.mopupEnd = false;
                     }
                     else
                     {
                        model.mopupEnd = true;
                     }
                  }
                  id = int(setTimeout(function():void
                  {
                     clearTimeout(id);
                     SocketSceneBufferManager.instance.addPkgToBuffer(pkg,"SPACE_SCENE",enterSpaceShow);
                  },1000));
                  break;
               case 10:
                  model.mopupEnd = true;
                  model.isNormalEnd = true;
                  break;
               case 11:
                  mopupTipData = LanguageMgr.GetTranslation("maze.MazeFrame.command01");
                  MessageTipManager.instance().show(mopupTipData);
                  break;
               case 13:
                  mopupTipData = LanguageMgr.GetTranslation("mopup.view.MazeMopupPrepareFrame.layerTipData2");
                  MessageTipManager.instance().show(mopupTipData);
                  break;
               case 14:
                  model.mopupEnd = true;
                  model.isNormalEnd = false;
                  break;
               case 15:
                  mopupTipData = LanguageMgr.GetTranslation("demonland.main.text7");
                  MessageTipManager.instance().show(mopupTipData);
                  break;
               case 16:
                  mopupTipData = LanguageMgr.GetTranslation("revengeroad.main.text7");
                  MessageTipManager.instance().show(mopupTipData);
                  break;
               case 8:
                  return;
            }
         }
         model.commit();
      }
      
      public function enterSpaceShow(param1:PackageIn) : void
      {
         var _loc2_:CampaignSweepRsp = new CampaignSweepRsp();
         _loc2_ = param1.readBody(_loc2_) as CampaignSweepRsp;
         switch(_loc2_.sweepType - 1)
         {
            case 0:
               FrameControllerManager.instance.openControllerByInfo("mopup",2);
               break;
            case 1:
               FrameControllerManager.instance.openControllerByInfo("mopup",4);
               break;
            case 2:
               FrameControllerManager.instance.openControllerByInfo("mopup",12,true);
               break;
            case 3:
               FrameControllerManager.instance.openControllerByInfo("mopup",14,true);
               break;
            case 4:
               FrameControllerManager.instance.openControllerByInfo("mopup",16,true);
               break;
            case 5:
               FrameControllerManager.instance.openControllerByInfo("mopup",20,true);
         }
      }
      
      public function sendMopupInfo(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 1, param7:Boolean = false, param8:Boolean = false, param9:int = 2) : void
      {
         var _loc11_:PackageOut = new PackageOut(8528);
         var _loc10_:CampaignSweepReq = new CampaignSweepReq();
         _loc10_.sweepType = param1;
         _loc10_.opType = param2;
         _loc10_.campaignId = param3;
         _loc10_.count = param4;
         _loc10_.eIndex = param5;
         _loc10_.enterType = param6;
         _loc10_.openSilverBox = param7;
         _loc10_.openSecretBox = param8;
         _loc10_.payType = param9;
         SocketSendManager.instance.sendProtoBuffer(_loc11_,_loc10_);
      }
   }
}

