package vehicle.daimon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.MovieClip;
   import manager.LanguageMgr;
   import mvc.module.vehicle.DaimonModel;
   import yishi.manager.FrameControllerManager;
   
   public class DaimonBottomView extends Component
   {
      
      private var _gradeTxt:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _gpTxt:FilterFrameText;
      
      private var _bg:Scale9CornerImage;
      
      private var _gpBar:MovieClip;
      
      public function DaimonBottomView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("daimonFrame.describeBackground_style01");
         _gpBar = ComponentFactory.Instance.creat("asset.daimon.VehicleGpBar");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("daimonBottomView.GradeTxt");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.HpTxt");
         _defenceTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.HpTxt");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("daimonLeftView.HpTxt");
         _gpTxt = ComponentFactory.Instance.creatComponentByStylename("mounts.GrowValueTxt");
         _gpBar.x = 179;
         _gpBar.y = 26;
         _attackTxt.x = 453;
         _defenceTxt.x = 581;
         _hpTxt.x = 300;
         _attackTxt.y = _defenceTxt.y = _hpTxt.y = 11;
         _gpTxt.x = 350;
         _gpTxt.y = 38;
         addChild(_bg);
         addChild(_gpBar);
         addChild(_gradeTxt);
         addChild(_attackTxt);
         addChild(_defenceTxt);
         addChild(_hpTxt);
         addChild(_gpTxt);
      }
      
      private function unitView() : void
      {
         _bg = null;
         _gpBar = null;
         _gradeTxt = null;
         _attackTxt = null;
         _defenceTxt = null;
         _defenceTxt = null;
         _gpTxt = null;
      }
      
      public function update() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DaimonModel = FrameControllerManager.instance.vehicleDaimonController.model;
         if(_loc1_)
         {
            _loc2_ = 100;
            if(_loc1_.maxGp > 0)
            {
               _loc2_ = Math.floor(_loc1_.curGp / _loc1_.maxGp * 100);
               _gpBar.gotoAndStop(_loc2_);
               _gpTxt.text = _loc1_.curGp + " / " + _loc1_.maxGp;
            }
            else
            {
               _loc2_ = 100;
               _gpBar.gotoAndStop(_loc2_);
               _gpTxt.text = "MAX";
            }
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_loc1_.grade);
            _attackTxt.text = "+" + _loc1_.attack;
            _defenceTxt.text = "+" + _loc1_.defence;
            _hpTxt.text = "+" + _loc1_.hp;
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         unitView();
         super.dispose();
      }
   }
}

