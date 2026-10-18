package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class FarmToolbar extends Sprite implements Disposeable
   {
      
      private var _myFarmBtn:IconButton;
      
      private var _curSelectedFarm:FarmInfo;
      
      public function FarmToolbar()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _myFarmBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmToolbarMyFarmBtn");
         _myFarmBtn.tipData = LanguageMgr.GetTranslation("farm.view.FarmToolbar.myFarm");
         addChild(_myFarmBtn);
      }
      
      private function addEvent() : void
      {
         model.addEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
         _myFarmBtn.addEventListener("click",__onMyFarmClick);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
         _myFarmBtn.removeEventListener("click",__onMyFarmClick);
      }
      
      private function __selectedFarmChangeHandler(param1:FarmEvent) : void
      {
         _curSelectedFarm = param1.data as FarmInfo;
         refreshView();
      }
      
      private function __onMyFarmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function refreshView() : void
      {
         if(_curSelectedFarm)
         {
            if(_curSelectedFarm.userId == thane.userId)
            {
               if(_myFarmBtn.parent)
               {
                  _myFarmBtn.parent.removeChild(_myFarmBtn);
               }
            }
            else
            {
               addChild(_myFarmBtn);
            }
         }
      }
      
      override public function get width() : Number
      {
         return 151;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_myFarmBtn)
         {
            _myFarmBtn.dispose();
         }
         _myFarmBtn = null;
         _curSelectedFarm = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

