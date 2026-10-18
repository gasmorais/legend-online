package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpGroupInfo;
   import mvc.module.chesspvp.ChessPvpModel;
   import mvc.module.chesspvp.ChessPvpOp;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class ChesspvpInLeftUI extends Sprite
   {
      
      protected var _bg:Bitmap;
      
      protected var _bg2:Bitmap;
      
      protected var _inRankBtn:BaseButton;
      
      protected var _inRecordBtn:BaseButton;
      
      protected var _inScoreBtn:BaseButton;
      
      protected var _inGroup:ChesspvpInLeftGroupUI;
      
      protected var _inJoinBtn:IconButton;
      
      protected var _inJoinbtnBg:Bitmap;
      
      private var _shape:Shape;
      
      private var _needPow:int;
      
      public function ChesspvpInLeftUI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.in.bg");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.chesspvp.inBtnBBg");
         _inJoinbtnBg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.in.jionbtnBg");
         _inRankBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRankBtn");
         _inRecordBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRecordBtn");
         _inScoreBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inScoreBtn");
         _inGroup = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.inGroup");
         _inJoinBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inJoinBtn");
         _shape = new Shape();
         _shape.graphics.beginFill(16711680);
         _shape.graphics.drawRect(0,0,235,_bg2.height);
         _shape.graphics.endFill();
         _shape.x = 8;
         _shape.y = _bg2.y;
         addChild(_bg);
         addChild(_bg2);
         addChild(_shape);
         addChild(_inJoinbtnBg);
         addChild(_inRankBtn);
         addChild(_inRecordBtn);
         addChild(_inScoreBtn);
         addChild(_inGroup);
         addChild(_inJoinBtn);
         _bg2.mask = _shape;
         _inGroup.visible = false;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("chess_pvp_sign_offer");
         if(_loc1_)
         {
            _needPow = int(_loc1_.ConfigValue);
         }
      }
      
      public function updateView() : void
      {
         var _loc1_:ChessPvpGroupInfo = model.selfGroupInfo;
         if(!_loc1_.isSignUp)
         {
            _inGroup.visible = false;
            _inJoinBtn.visible = true;
            _bg2.visible = true;
            _inJoinbtnBg.visible = true;
         }
         else
         {
            _inGroup.visible = true;
            _inGroup.updateView(_loc1_);
            _inJoinBtn.visible = false;
            _bg2.visible = false;
            _inJoinbtnBg.visible = false;
         }
      }
      
      private function get model() : ChessPvpModel
      {
         return ChessPvpManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         _inRankBtn.addEventListener("click",rankHandler);
         _inRecordBtn.addEventListener("click",recordHandler);
         _inScoreBtn.addEventListener("click",shopHandler);
         _inJoinBtn.addEventListener("click",jionHandler);
      }
      
      private function removeEvent() : void
      {
         _inRankBtn.removeEventListener("click",rankHandler);
         _inRecordBtn.removeEventListener("click",recordHandler);
         _inScoreBtn.removeEventListener("click",shopHandler);
         _inJoinBtn.removeEventListener("click",jionHandler);
      }
      
      private function rankHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("chesspvp",4);
      }
      
      private function recordHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("chesspvp",5);
      }
      
      private function shopHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",2,{"chesspvp":true});
      }
      
      private function jionHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("chesspvp.in.joinNeed",_needPow);
         SimpleAlertHelper.instance.data = [__alertResponse];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ChessPvpManager.Instance.operFun(ChessPvpOp.OP_SIGN);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_inJoinbtnBg);
         _inJoinbtnBg = null;
         ObjectUtils.disposeObject(_inRankBtn);
         _inRankBtn = null;
         ObjectUtils.disposeObject(_inRecordBtn);
         _inRecordBtn = null;
         ObjectUtils.disposeObject(_inScoreBtn);
         _inScoreBtn = null;
         ObjectUtils.disposeObject(_inGroup);
         _inGroup = null;
         ObjectUtils.disposeObject(_inJoinBtn);
         _inJoinBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

