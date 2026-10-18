package armyII.viewII.stone.item
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.vicePassword.VicePasswordUtil;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class RuneCellMenu extends Sprite implements Disposeable
   {
      
      private var _currentItem:BaseItemView;
      
      private var _back:ScaleBitmapImage;
      
      private var _resovleBtn:TextButton;
      
      private var _upBtn:TextButton;
      
      private var _lockBtn:TextButton;
      
      private var _vBox:VBox;
      
      public function RuneCellMenu(param1:BaseItemView)
      {
         super();
         _currentItem = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _resovleBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
         _resovleBtn.text = LanguageMgr.GetTranslation("army.stone.menu.Resolve");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("core.MoveButton");
         _upBtn.text = LanguageMgr.GetTranslation("army.stone.menu.upGrade");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("core.MoveButton");
         _lockBtn.text = LanguageMgr.GetTranslation("chat.view.ChatBtnContainer.lockTipData01");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("core.GoodsItemMenuContain");
         addChild(_vBox);
         _vBox.beginChanges();
         if(!_currentItem.data.isLock)
         {
            _vBox.addChild(_resovleBtn);
         }
         else
         {
            _vBox.addChild(_lockBtn);
         }
         _vBox.addChild(_upBtn);
         _vBox.commitChanges();
      }
      
      private function initEvent() : void
      {
         _resovleBtn.addEventListener("click",__resoveHandler);
         _upBtn.addEventListener("click",__upHandler);
         _lockBtn.addEventListener("click",unLockHandler);
      }
      
      private function removeEvent() : void
      {
         if(_resovleBtn)
         {
            _resovleBtn.removeEventListener("click",__resoveHandler);
         }
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upHandler);
         }
         if(_lockBtn)
         {
            _lockBtn.removeEventListener("click",unLockHandler);
         }
      }
      
      private function unLockHandler(param1:MouseEvent) : void
      {
         if(_currentItem && _currentItem.data)
         {
            VicePasswordUtil.vpLockOp(7,_currentItem.data.pos);
            dispose();
         }
      }
      
      private function __resoveHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         if(_currentItem && _currentItem.data)
         {
            _loc5_ = "" + _currentItem.data.pos;
            if(_currentItem.data.templateInfo.Profile >= 4)
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("stoneGetView.resovle.tip2");
               SimpleAlertHelper.instance.data = [__alertResponse,_loc5_];
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc6_,_loc2_,_loc3_,false,true);
            }
            else
            {
               ArmySocketOutManager.sendEquipResoveStone(_loc5_);
               dispose();
            }
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:String) : void
      {
         if(param1)
         {
            ArmySocketOutManager.sendEquipResoveStone(param3);
         }
         dispose();
      }
      
      private function __upHandler(param1:MouseEvent) : void
      {
         if(_currentItem && _currentItem.data)
         {
            FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.FUSHI_INSTENSIFY;
            FrameControllerManager.instance.openControllerByInfo("army",null,_currentItem.data);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         StageReferance.stage.focus = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_resovleBtn);
         _resovleBtn = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         _currentItem = null;
      }
   }
}

