package kingcontract
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.KingContractManager;
   import mvc.module.kingcontract.KingContractInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.community.BaseIconView;
   
   public class KingContractView extends Sprite implements Disposeable
   {
      
      private var _itemBg:Bitmap;
      
      private var _btn:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _discribeTxt:FilterFrameText;
      
      private var _filter:UIFilter;
      
      private var _kingInfo:KingContractInfo;
      
      public function KingContractView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.kingcontract.itemsBg");
         _btn = ComponentFactory.Instance.creatCustomObject("kingcontract.KingItemIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("kingcontract.BuffNameTxt");
         _discribeTxt = ComponentFactory.Instance.creatComponentByStylename("kingcontract.KingContractView.DiscribeTxt");
         _filter = new UIFilter();
         addChild(_itemBg);
         addChild(_btn);
         addChild(_nameTxt);
         addChild(_discribeTxt);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("rollOver",__onItemOver);
         _btn.addEventListener("rollOut",__onItemOut);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("rollOver",__onItemOver);
         _btn.removeEventListener("rollOut",__onItemOut);
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         _filter.setLightingFilter(_btn);
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(_btn);
      }
      
      private function __alertBackHandler(param1:Boolean) : void
      {
         var _loc2_:Array = null;
         if(param1)
         {
            if(playerInfo.point < _kingInfo.template.NeedPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            _loc2_ = [_kingInfo.templateId];
            KingContractManager.Instance.sendKingContract(_loc2_);
         }
      }
      
      public function set data(param1:KingContractInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _kingInfo = param1;
         _btn.icon = ComponentFactory.Instance.creatBitmap("asset.kingcontract.icon" + _kingInfo.templateId);
         _btn.tipData = param1;
         _nameTxt.text = _kingInfo.template.Name;
         _discribeTxt.text = _kingInfo.template.Description;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _filter.setNormalFilter(_btn);
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function get currentTime() : Date
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime;
      }
   }
}

