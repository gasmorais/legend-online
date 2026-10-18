package theseusdoublepvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.TextAddBitmap;
   
   public class TheseusDoublepvpPrivateCItem extends Sprite
   {
      
      public var _unlockbg:Bitmap;
      
      public var _prcnormaltxt:FilterFrameText;
      
      public var _prcadvtxt:FilterFrameText;
      
      private var _priceNum:TextAddBitmap;
      
      private var _unLockBtn:BaseButton;
      
      private var _lockFlg:Image;
      
      private var _Num:int;
      
      public function TheseusDoublepvpPrivateCItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _unlockbg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.unlockbg");
         _prcnormaltxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.prcnormaltxt");
         _prcadvtxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.prcadvtxt");
         _unLockBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.gloryAdvBtn");
         _priceNum = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.gloryPriceBit");
         _priceNum.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         _lockFlg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.private.adVancelock");
         addChild(_unlockbg);
         addChild(_prcnormaltxt);
         addChild(_prcadvtxt);
         addChild(_priceNum);
         addChild(_unLockBtn);
         addChild(_lockFlg);
         _prcnormaltxt.text = LanguageMgr.GetTranslation("theseuspvp.gloryNormal");
         _prcadvtxt.text = LanguageMgr.GetTranslation("theseuspvp.gloryAdvance");
         _Num = TempleteManager.instance.getConfigValue("specialrewar_theseus_multi_diamonds");
         _priceNum.setText("" + _Num);
         _unLockBtn.enable = false;
      }
      
      public function updateState(param1:Boolean) : void
      {
         _unLockBtn.enable = !param1;
         _lockFlg.visible = !param1;
      }
      
      private function initEvent() : void
      {
         _unLockBtn.addEventListener("click",unLockHandler);
      }
      
      private function removeEvent() : void
      {
         _unLockBtn.removeEventListener("click",unLockHandler);
      }
      
      private function unLockHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("theseuspvp.gloryAdvanceAlert",_Num);
         SimpleAlertHelper.instance.data = [__alertResponse];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            TheseusPvpManager.Instance.doSomething1(9);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_unlockbg);
         _unlockbg = null;
         ObjectUtils.disposeObject(_prcnormaltxt);
         _prcnormaltxt = null;
         ObjectUtils.disposeObject(_prcadvtxt);
         _prcadvtxt = null;
         ObjectUtils.disposeObject(_priceNum);
         _priceNum = null;
         ObjectUtils.disposeObject(_unLockBtn);
         _unLockBtn = null;
         ObjectUtils.disposeObject(_lockFlg);
         _lockFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

