package ancientartifact.view
{
   import ancientartifact.view.item.AcnientCheckListItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.manager.AncientArtifactManager;
   
   public class AcnientCheckList extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vbox:VBox;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _acnientId:int;
      
      private var _pos:int;
      
      public function AcnientCheckList(param1:int = 0, param2:int = 0)
      {
         super();
         _acnientId = param1;
         _pos = param2;
         initView();
         initEvent();
         initListInfo();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.checkmenuBg");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.checkVbox");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.ScrollPanel");
         addChild(_bg);
         addChild(_scrolPanel);
         _bg.width = 88;
         _bg.height = 195;
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vbox,true);
         _scrolPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
      }
      
      private function initListInfo() : void
      {
         var _loc2_:AcnientCheckListItem = null;
         var _loc7_:int = 0;
         var _loc1_:Array = model.artifactList;
         var _loc3_:int = int(_loc1_.length);
         var _loc5_:Array = [];
         var _loc4_:AncientArtifactInfo = model.getArtifactInfoById(_acnientId);
         var _loc6_:int = 0;
         while(_loc6_ < 5)
         {
            if(_loc4_ && _loc4_["slotedEquipPos" + (_loc6_ + 1)] > 0)
            {
               _loc5_.push(_loc4_["slotedEquipPos" + (_loc6_ + 1)]);
            }
            _loc6_ += 1;
         }
         if(_loc4_ && _loc4_["slotedEquipPos" + _pos] > 0)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ancientartifact.AcnientCheckListItem",[_pos]);
            _loc2_.anctientId = 0;
            _vbox.addChild(_loc2_);
            _loc2_.addEventListener("click",__onClickHander);
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = int(_loc1_[_loc6_].templateId);
            if(_loc7_ != _acnientId && _loc5_.indexOf(_loc7_) < 0)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ancientartifact.AcnientCheckListItem",[_pos]);
               _loc2_.anctientId = _loc7_;
               _vbox.addChild(_loc2_);
               _loc2_.addEventListener("click",__onClickHander);
            }
            _loc6_ += 1;
         }
         _scrolPanel.invalidateViewport();
      }
      
      private function __onClickHander(param1:MouseEvent) : void
      {
         var _loc2_:AcnientCheckListItem = param1.currentTarget as AcnientCheckListItem;
         if(!_loc2_)
         {
            return;
         }
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.RESON_EQUIP,_acnientId,0,false,_pos,_loc2_.anctientId);
         dispose();
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AcnientCheckListItem = null;
         if(_vbox)
         {
            _loc2_ = 0;
            while(_loc2_ < _vbox.numChildren)
            {
               _loc1_ = _vbox.getChildAt(_loc2_) as AcnientCheckListItem;
               _loc1_.removeEventListener("click",__onClickHander);
               _loc2_ += 1;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrolPanel);
         _scrolPanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

