package map.campaign.view.ui.svsmap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SvsManageView extends Sprite implements Disposeable
   {
      
      private var _memberBtn:BaseButton;
      
      private var _beginWarBtn:BaseButton;
      
      private var _cost:int = 100;
      
      public function SvsManageView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _memberBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.MemberBtn");
         _beginWarBtn = ComponentFactory.Instance.creatComponentByStylename("svs.SvsView.BeginWarBtn");
         addChild(_memberBtn);
         addChild(_beginWarBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _memberBtn.addEventListener("click",__memberBtnClickHandler);
         if(_beginWarBtn)
         {
            _beginWarBtn.addEventListener("click",__beginWarBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         _memberBtn.removeEventListener("click",__memberBtnClickHandler);
         if(_beginWarBtn)
         {
            _beginWarBtn.removeEventListener("click",__beginWarBtnClickHandler);
         }
      }
      
      private function __memberBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("svsmap",1);
      }
      
      private function __beginWarBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:Date = null;
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         var _loc5_:Boolean = true;
         var _loc2_:Date = SharedManager.instance.svsBeginWar;
         if(_loc2_)
         {
            _loc4_ = new Date();
            if(_loc4_.fullYear == _loc2_.fullYear && _loc4_.month == _loc2_.month && _loc4_.date == _loc2_.date)
            {
               _loc5_ = false;
            }
         }
         if(_loc5_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc6_ = LanguageMgr.GetTranslation("svsFrame.svsManageView.beginWarCost",_cost);
            _loc3_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
            _loc7_.show(_loc6_,_loc3_,__todayNotAlertTidy,null,"center",1,true);
         }
         else
         {
            beginWar();
         }
      }
      
      private function __todayNotAlertTidy(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.svsBeginWar = new Date();
            SharedManager.instance.saveSvsBeginWar();
         }
         beginWar();
      }
      
      private function beginWar() : void
      {
         if(playerInfo.point < _cost)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("svsFrame.svsManageView.Cost"));
            return;
         }
         FrameControllerManager.instance.svsController.sendImmediateWar();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

