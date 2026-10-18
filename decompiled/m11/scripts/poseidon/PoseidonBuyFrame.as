package poseidon
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PoseidonManager;
   import poseidon.view.PoseidonBuyView;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.PoseidonShopTempInfo;
   import yishi.utils.SimpleAlertHelper;
   
   public class PoseidonBuyFrame extends Frame
   {
      
      private var _view:PoseidonBuyView;
      
      public function PoseidonBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = ComponentFactory.Instance.creatCustomObject("ui.poseidonshop.PoseidonBuyView");
         addToContent(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _view._buyConfrim.addEventListener("click",confrimHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _view._buyConfrim.removeEventListener("click",confrimHandler);
      }
      
      private function confrimHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(_view.info)
         {
            _loc4_ = _view.doBuyNum;
            if(_view.info.ShopType == 2)
            {
               _loc5_ = _loc4_ * _view.info.Price;
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc6_ = LanguageMgr.GetTranslation("public.prompt");
               _loc7_ = LanguageMgr.GetTranslation("poseidon.shopConfirmContent",_loc5_,_loc4_,_view.getGoodsName());
               SimpleAlertHelper.instance.data = [__alertResponse,_view.info.Id,_loc4_];
               SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,false,true);
            }
            else
            {
               __alertResponse(true,false,_view.info.Id,_loc4_);
            }
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         if(param1)
         {
            PoseidonManager.Ins.buyGood(_view.info.Id,param4);
            dispose();
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show(param1:PoseidonShopTempInfo = null) : void
      {
         titleText = LanguageMgr.GetTranslation("public.prompt");
         if(param1)
         {
            _view.info = param1;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

