package cell.view.playerequip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class HonorCell extends PlayerEquipCell
   {
      
      private var _upBtn:IconButton;
      
      public function HonorCell()
      {
         super();
         bagType = 3;
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(!_upBtn)
         {
            _upBtn = ComponentFactory.Instance.creatComponentByStylename("MarryRingView.upBtn");
            _upBtn.addEventListener("click",__upBtnClickHandler);
            addChild(_upBtn);
         }
         if(isCanUpdate && param1.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            _upBtn.visible = true;
         }
         else
         {
            _upBtn.visible = false;
         }
      }
      
      private function get isCanUpdate() : Boolean
      {
         var _loc1_:Array = null;
         if(data && data.templateInfo.SonType == 301)
         {
            _loc1_ = TempleteManager.instance.getTemplatesByType(43);
            for each(var _loc2_:UpgradeTemplateInfo in _loc1_)
            {
               if(_loc2_.TemplateId == data.templateId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function __upBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.armyController.openMedalFrame();
      }
      
      public function setTipDate(param1:String) : void
      {
         (_back as ScaleFrameImage).tipData = param1;
      }
      
      override public function setFocus() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = true;
            _activeBack.movie.play();
         }
      }
      
      override public function dispose() : void
      {
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upBtnClickHandler);
         }
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         super.dispose();
      }
   }
}

