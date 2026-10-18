package childnswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarUserInfo;
   import yishi.datas.templates.ChildNswarTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildNswarLeftView extends Sprite
   {
      
      public var _vProBarBg:Bitmap;
      
      public var _vProBar:Bitmap;
      
      public var _leftIconm1:Image;
      
      public var _leftIconm2:Image;
      
      public var _leftIconm3:Image;
      
      public var _leftIconm4:Image;
      
      public var _leftIconm5:Image;
      
      public var _leftIconm6:Image;
      
      private var _barMask:Shape;
      
      private var _maxScore:int;
      
      private var _paraList:Array = [];
      
      public function ChildNswarLeftView()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _vProBarBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.vProBarBg");
         _vProBar = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.vProBar");
         _leftIconm1 = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.leftIconm1");
         _leftIconm2 = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.leftIconm2");
         _leftIconm3 = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.leftIconm3");
         _leftIconm4 = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.leftIconm4");
         _leftIconm5 = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.leftIconm5");
         _leftIconm6 = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.leftIconm6");
         _barMask = new Shape();
         addChild(_vProBarBg);
         addChild(_vProBar);
         addChild(_barMask);
         addChild(_leftIconm1);
         addChild(_leftIconm2);
         addChild(_leftIconm3);
         addChild(_leftIconm4);
         addChild(_leftIconm5);
         addChild(_leftIconm6);
         _vProBar.mask = _barMask;
         _barMask.x = _vProBar.x;
         _barMask.y = _vProBar.y + _vProBar.height;
      }
      
      private function progressValue(param1:int, param2:int) : void
      {
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc3_:int = -getMHeight(param1);
         _barMask.graphics.clear();
         _barMask.graphics.beginFill(16711680);
         _barMask.graphics.drawRect(0,0,_vProBar.width,_loc3_);
         _barMask.graphics.endFill();
      }
      
      private function getMHeight(param1:int) : int
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int;
         var _loc6_:* = _loc5_ = int(_paraList.length);
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            if(param1 <= _paraList[_loc7_])
            {
               _loc6_ = _loc7_;
               break;
            }
            _loc7_++;
         }
         var _loc2_:int = 0;
         if(_loc6_ > 0)
         {
            _loc8_ = _vProBar.height / 5;
            _loc3_ = param1 - _paraList[_loc6_ - 1];
            _loc4_ = _paraList[_loc6_] - _paraList[_loc6_ - 1];
            if(_loc3_ > _loc4_)
            {
               _loc3_ = _loc4_;
            }
            _loc2_ = _loc3_ / _loc4_ * _loc8_ + (_loc6_ - 1) * _loc8_;
         }
         return _loc2_;
      }
      
      private function initData() : void
      {
         var _loc1_:ChildNswarTempInfo = TempleteManager.instance.childNswarCate.getTempByType(1,1);
         _leftIconm1.tipData = LanguageMgr.GetTranslation("theseuspvp.stepNeedScore",_loc1_.NeedIntegral);
         _paraList.push(_loc1_.NeedIntegral);
         _loc1_ = TempleteManager.instance.childNswarCate.getTempByType(2,1);
         _leftIconm2.tipData = LanguageMgr.GetTranslation("theseuspvp.stepNeedScore",_loc1_.NeedIntegral);
         _paraList.push(_loc1_.NeedIntegral);
         _loc1_ = TempleteManager.instance.childNswarCate.getTempByType(3,1);
         _leftIconm3.tipData = LanguageMgr.GetTranslation("theseuspvp.stepNeedScore",_loc1_.NeedIntegral);
         _paraList.push(_loc1_.NeedIntegral);
         _loc1_ = TempleteManager.instance.childNswarCate.getTempByType(4,1);
         _leftIconm4.tipData = LanguageMgr.GetTranslation("theseuspvp.stepNeedScore",_loc1_.NeedIntegral);
         _paraList.push(_loc1_.NeedIntegral);
         _loc1_ = TempleteManager.instance.childNswarCate.getTempByType(5,1);
         _leftIconm5.tipData = LanguageMgr.GetTranslation("theseuspvp.stepNeedScore",_loc1_.NeedIntegral);
         _paraList.push(_loc1_.NeedIntegral);
         _loc1_ = TempleteManager.instance.childNswarCate.getTempByType(6,1);
         _leftIconm6.tipData = LanguageMgr.GetTranslation("theseuspvp.stepNeedScore",_loc1_.NeedIntegral);
         _paraList.push(_loc1_.NeedIntegral);
         _maxScore = _loc1_.NeedIntegral;
         updateProgressHandler();
      }
      
      private function updateProgressHandler(param1:Event = null) : void
      {
         var _loc2_:ChildNswarUserInfo = ChildNswarManager.Instance.model.selfUserInfo;
         progressValue(_loc2_.integral,_maxScore);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_vProBarBg);
         _vProBarBg = null;
         ObjectUtils.disposeObject(_vProBar);
         _vProBar = null;
         ObjectUtils.disposeObject(_barMask);
         _barMask = null;
         ObjectUtils.disposeObject(_leftIconm1);
         _leftIconm1 = null;
         ObjectUtils.disposeObject(_leftIconm2);
         _leftIconm2 = null;
         ObjectUtils.disposeObject(_leftIconm3);
         _leftIconm3 = null;
         ObjectUtils.disposeObject(_leftIconm4);
         _leftIconm4 = null;
         ObjectUtils.disposeObject(_leftIconm5);
         _leftIconm5 = null;
         ObjectUtils.disposeObject(_leftIconm6);
         _leftIconm6 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

