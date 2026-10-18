package battle.handler
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.skillsys.helper.BloodHelper;
   import battle.view.roles.RoleViewBase;
   import battle.view.ui.BossBottomStrip;
   import chat.ChatManager;
   import chat.datas.ChatData;
   import com.road.yishi.proto.battle.ReliveMsg;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.events.RoleEvent;
   import yishi.manager.NotificationManager;
   
   public class ReviveHandler implements IPackageHandler
   {
      
      public function ReviveHandler()
      {
         super();
      }
      
      public function handle(param1:PackageIn) : void
      {
         var targetInfoView:RoleViewBase;
         var updateBloodObject:Object;
         var cureEffectObject:Object;
         var chatData:ChatData;
         var pkg:PackageIn = param1;
         var curMsg:ReliveMsg = new ReliveMsg();
         curMsg = pkg.readBody(curMsg) as ReliveMsg;
         var targetInfo:HeroRoleInfo = BattleManager.getInstance().battleModel.getRoleById(curMsg.livingId) as HeroRoleInfo;
         targetInfo.isLiving = true;
         targetInfo.riveve = true;
         targetInfo.dying = false;
         targetInfo.action("Stand","REPEAT");
         targetInfo.bloodA = targetInfo.totalBloodA;
         targetInfo.needShow = false;
         BloodHelper.resetRoleBlood(targetInfo);
         targetInfoView = targetInfo.view;
         if(targetInfoView != null)
         {
            if(targetInfo.map == undefined)
            {
               if(BattleManager.getInstance().battleMap != null)
               {
                  BattleManager.getInstance().battleMap.addRole(targetInfoView);
               }
               else
               {
                  NotificationManager.instance.addEventListener("enterbattlescene",function(param1:BattleEvent):void
                  {
                     NotificationManager.instance.removeEventListener("enterbattlescene",arguments.callee);
                     BattleManager.getInstance().battleMap.addRole(targetInfoView);
                  });
               }
            }
            else
            {
               targetInfo.map.revierBoss(targetInfoView);
            }
            targetInfoView.setRoleInfoViewVisible(true);
            if(targetInfoView.stripView is BossBottomStrip)
            {
               (targetInfoView.stripView as BossBottomStrip).resetView();
            }
            updateBloodObject = {
               "bloodType":10,
               "blood":0,
               "displayBlood":targetInfo.totalBloodA,
               "havoc":false,
               "selfCause":false,
               "isDefault":false,
               "isParry":false
            };
            targetInfo.dispatchEvent(new RoleEvent("bloodChange",updateBloodObject));
            switch(BattleManager.getInstance().battleModel.battleType - 311)
            {
               case 0:
               case 1:
               case 2:
                  if(BattleManager.getInstance().battleUIView != null)
                  {
                     BattleManager.getInstance().battleUIView.updateMutilRoleShowView(true);
                  }
                  else
                  {
                     NotificationManager.instance.addEventListener("enterbattlescene",function(param1:BattleEvent):void
                     {
                        NotificationManager.instance.removeEventListener("enterbattlescene",arguments.callee);
                        BattleManager.getInstance().battleUIView.updateMutilRoleShowView(true);
                     });
                  }
            }
            if(!BattleManager.getInstance().battleModel.isHideOtherInBattle(targetInfo))
            {
               cureEffectObject = {
                  "effect":"buff.action.cure2",
                  "repeat":1,
                  "x":0,
                  "y":0
               };
               targetInfo.showDannyEffect(cureEffectObject);
            }
         }
         chatData = new ChatData();
         chatData.channel = 3;
         chatData.type = 1;
         chatData.msg = LanguageMgr.GetTranslation("battle.actions.DannyAction.ChatDataMsg");
         chatData.commit();
         ChatManager.instance.model.addChat(chatData);
         BattleManager.getInstance().battleModel.isOver = false;
      }
   }
}

