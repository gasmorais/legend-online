package apex.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ApexEvent;
   import flash.display.Bitmap;
   import mvc.module.apex.ApexModel;
   import yishi.manager.ApexManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.TimerUtils;
   
   public class ApexRoomTopView extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var _bit5:Bitmap;
      
      private var _txtRoomTopTurn:FilterFrameText;
      
      private var _txtRoomTopTime:FilterFrameText;
      
      private var _apexRoomTopBg:MutipleImage;
      
      private var n:int;
      
      public function ApexRoomTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apexroom.top.str1");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apexroom.top.str4");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.apexroom.top.str2");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.apexroom.top.str3");
         _bit5 = ComponentFactory.Instance.creatBitmap("asset.apexroom.top.str5");
         _txtRoomTopTurn = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomTopTurn");
         _txtRoomTopTime = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.txtRoomTopTime");
         _apexRoomTopBg = ComponentFactory.Instance.creatComponentByStylename("ui.apexroom.apexRoomTopBg");
         addChild(_apexRoomTopBg);
         addChild(_bit0);
         addChild(_bit1);
         addChild(_bit2);
         addChild(_bit5);
         addChild(_txtRoomTopTurn);
         addChild(_txtRoomTopTime);
         battleStateUpdate();
      }
      
      private function addEvent() : void
      {
         ApexManager.instance.addEventListener("REFRESH_BATTLE_STATE",battleStateUpdate);
         TimerUtils.addSecendTimer("ApexRoomTopView",1,2147483647,tick);
      }
      
      private function removeEvent() : void
      {
         ApexManager.instance.removeEventListener("REFRESH_BATTLE_STATE",battleStateUpdate);
         TimerUtils.removeSecendTimer("ApexRoomTopView");
      }
      
      private function tick() : void
      {
         if(model.apexBattleState)
         {
            n = (model.apexBattleState.nextStartTime - PlayerManager.instance.currentPlayerModel.sysCurtime.time) / 1000;
            if(n < 0)
            {
               n = 0;
            }
            _txtRoomTopTime.text = n + "";
            if(model.apexBattleState.currentTurn == model.apexBattleState.maxTurn && n == 0)
            {
               _bit0.visible = false;
               _bit1.visible = false;
               _bit2.visible = false;
               _bit3.visible = false;
               _bit5.visible = true;
               _txtRoomTopTurn.visible = false;
               _txtRoomTopTime.visible = false;
            }
            else
            {
               _bit0.visible = true;
               _bit1.visible = true;
               _bit2.visible = true;
               _bit3.visible = true;
               _bit5.visible = false;
               _txtRoomTopTurn.visible = true;
               _txtRoomTopTime.visible = true;
            }
         }
      }
      
      private function battleStateUpdate(param1:ApexEvent = null) : void
      {
         if(model.apexBattleState)
         {
            visible = true;
            _txtRoomTopTurn.text = model.apexBattleState.currentTurn + "/" + model.apexBattleState.maxTurn;
         }
         else
         {
            visible = false;
         }
      }
      
      public function get model() : ApexModel
      {
         return ApexManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_bit5);
         _bit5 = null;
         ObjectUtils.disposeObject(_txtRoomTopTurn);
         _txtRoomTopTurn = null;
         ObjectUtils.disposeObject(_txtRoomTopTime);
         _txtRoomTopTime = null;
         ObjectUtils.disposeObject(_apexRoomTopBg);
         _apexRoomTopBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

