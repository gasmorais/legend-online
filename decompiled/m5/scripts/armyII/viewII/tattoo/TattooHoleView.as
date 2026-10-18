package armyII.viewII.tattoo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.controler.TattooController;
   import mvc.module.tattoo.TattooHole;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   
   public class TattooHoleView extends Component implements Disposeable
   {
      
      private static const PROPERTY_NAME:Array = ["strength","agility","intelligence","captain","","physique"];
      
      private var _index:int = 0;
      
      private var _tattooLock:Image;
      
      private var _tattooUnlock:Image;
      
      private var _tattooIcon:Image;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _isSelf:Boolean;
      
      public function TattooHoleView(param1:int, param2:Boolean = true, param3:ThaneInfo = null)
      {
         _isSelf = param2;
         _thaneInfo = param3;
         super();
         _index = param1;
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         _tattooLock = ComponentFactory.Instance.creatComponentByStylename("tattoo.tattooLock");
         _tattooUnlock = ComponentFactory.Instance.creatComponentByStylename("tattoo.tattooUnlock");
         addChild(_tattooUnlock);
         addChild(_tattooLock);
         _tattooUnlock.visible = false;
      }
      
      public function refresh() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc5_:Array = FrameControllerManager.instance.tattooController.tattooModel.holes;
         if(!_isSelf)
         {
            _loc5_ = _thaneInfo.holes;
         }
         if(!_loc5_ || index > _loc5_.length - 1)
         {
            return;
         }
         _tattooLock.visible = false;
         var _loc1_:TattooHole = _loc5_[index] as TattooHole;
         if(_tattooIcon)
         {
            ObjectUtils.disposeObject(_tattooIcon);
         }
         var _loc2_:int = _loc1_.oldAddingValue < tattooController.tattooModel.getPrimaryTattooMaxAddValue() ? 1 : 2;
         if(_loc1_.oldAddProperty >= 0)
         {
            _tattooUnlock.visible = false;
            _tattooIcon = ComponentFactory.Instance.creatComponentByStylename("tattoo." + PROPERTY_NAME[_loc1_.oldAddProperty] + _loc2_);
            if(_loc2_ == 2)
            {
               _tattooIcon.x = -15;
               _tattooIcon.y = -15;
            }
            addChild(_tattooIcon);
            this.tipStyle = "yishi.view.tips.OneLineTip";
            this.isFollowMouse = false;
            this.tipDirctions = "2,1";
            _loc3_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName" + _loc1_.oldAddProperty);
            _loc4_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName" + _loc1_.oldReduceProperty);
            _loc6_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyLvl" + _loc2_) + _loc3_ + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattoo") + "\n" + _loc3_ + "  +" + _loc1_.oldAddingValue + "\n" + _loc4_ + "  " + _loc1_.oldReduceValue;
            if(_isSelf)
            {
               _loc6_ += "\n \n" + LanguageMgr.GetTranslation("tattoo.TattooFrame.clickToRefresh");
            }
            this.tipData = _loc6_;
         }
         else
         {
            _tattooUnlock.visible = true;
         }
      }
      
      private function addEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_tattooLock);
         _tattooLock = null;
         ObjectUtils.disposeObject(_tattooUnlock);
         _tattooUnlock = null;
      }
      
      private function get tattooController() : TattooController
      {
         return FrameControllerManager.instance.tattooController;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
   }
}

