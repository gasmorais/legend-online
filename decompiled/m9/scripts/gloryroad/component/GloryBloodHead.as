package gloryroad.component
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.GloryroadManager;
   import mvc.module.gloryroad.GloryRoadModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseIconView;
   
   public class GloryBloodHead extends Component
   {
      
      private var _progress:ProgressCommon;
      
      private var _selfIcon:BaseIconView;
      
      public function GloryBloodHead()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _progress = ComponentFactory.Instance.creatComponentByStylename("gloryroad.progress");
         _selfIcon = ComponentFactory.Instance.creatCustomObject("gloryroad.ChildrenIcon");
         _selfIcon.mask = createSprite();
         _selfIcon.icon = IconFactory.getHeadIcon(ArmyManager.instance.thane.snsInfo.headId,"smallhead",".jpg");
         addChild(_progress);
         addChild(_selfIcon);
         this.x = 60;
         this.y = 630;
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.tipData = LanguageMgr.GetTranslation("GloryBloodHead.initView.bloodTipData");
      }
      
      private function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(25,26,22);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function updateHead() : void
      {
         _selfIcon.icon = IconFactory.getHeadIcon(ArmyManager.instance.thane.snsInfo.headId,"smallhead",".jpg");
      }
      
      public function updateBood() : void
      {
         var _loc4_:int = 0;
         var _loc3_:ThaneInfo = ArmyManager.instance.thane;
         var _loc2_:Object = model.getBuffAtts()[1];
         var _loc1_:Number = Number(_loc2_.per);
         var _loc5_:Number = Number(_loc2_.value);
         if(model.remainHp)
         {
            _loc4_ = int(model.remainHp.low);
            _progress.value = _loc4_ / (_loc3_.attackProrerty.totalLive * ((100 + _loc1_) / 100) + _loc5_);
            if(_loc4_ <= 0)
            {
               this.filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               this.filters = null;
            }
         }
      }
      
      private function get model() : GloryRoadModel
      {
         return GloryroadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_selfIcon);
         _selfIcon = null;
         super.dispose();
      }
   }
}

