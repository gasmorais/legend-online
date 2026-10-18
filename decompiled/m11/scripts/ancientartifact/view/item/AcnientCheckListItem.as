package ancientartifact.view.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AcnientCheckListItem extends Component implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _iconView:BaseIconView;
      
      private var _pos:int;
      
      private var _anctientId:int;
      
      public function AcnientCheckListItem(param1:int)
      {
         _pos = param1;
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,60,60);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.bagEquipBack");
         _iconView = ComponentFactory.Instance.creatCustomObject("ancientartifact.ResonateItemIcon");
         addChild(_back);
         addChild(_iconView);
         _iconView.x = 0;
         _iconView.y = 0;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      public function set anctientId(param1:int) : void
      {
         var _loc7_:AncientArtifactInfo = null;
         var _loc4_:AncientResonateInfo = null;
         var _loc6_:UpgradeTemplateInfo = null;
         var _loc5_:Number = NaN;
         _anctientId = param1;
         this.tipData = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryEquipTips02");
         var _loc2_:ArtifactTemplateInfo = TempleteManager.instance.artifactTemplateCate.getTemplateById(param1);
         var _loc3_:String = "";
         if(_loc2_)
         {
            _iconView.icon = IconFactory.getCommonIconPath(_loc2_.Icon);
            _loc4_ = model.getResonateInfoByPos(_pos);
            _loc6_ = TempleteManager.instance.getTemplateByLevelAndType(_loc4_.posGrades,137);
            _loc7_ = model.getArtifactInfoById(_anctientId);
            _loc5_ = _loc7_.addPer / 100;
            if(_pos == 1)
            {
               _loc3_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt01",Math.floor(_loc7_.attack * _loc6_.ActiveObject / 100 * _loc5_));
               _loc3_ += "\n" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt03",Math.floor(_loc7_.magicAttack * _loc6_.ActiveObject / 100 * _loc5_));
            }
            else if(_pos == 2)
            {
               _loc3_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt02",Math.floor(_loc7_.defences * _loc6_.ActiveObject / 100 * _loc5_));
               _loc3_ += "\n" + LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt04",Math.floor(_loc7_.magicDefences * _loc6_.ActiveObject / 100 * _loc5_));
            }
            else if(_pos == 3)
            {
               _loc3_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt06",Math.floor(_loc7_.parry * _loc6_.ActiveObject / 100 * _loc5_));
            }
            else if(_pos == 4)
            {
               _loc3_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt05",Math.floor(_loc7_.penetrate * _loc6_.ActiveObject / 100 * _loc5_));
            }
            else if(_pos == 5)
            {
               _loc3_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.resonateTxt07",Math.floor(_loc7_.live * _loc6_.ActiveObject / 100 * _loc5_));
            }
            this.tipData = _loc3_;
         }
         else
         {
            _iconView.icon = null;
         }
      }
      
      public function get anctientId() : int
      {
         return _anctientId;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         super.dispose();
      }
   }
}

