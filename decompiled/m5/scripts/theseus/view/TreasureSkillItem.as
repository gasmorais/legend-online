package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   
   public class TreasureSkillItem extends Component
   {
      
      private var _item:BaseItemView;
      
      private var _lock:Bitmap;
      
      private var _index:int;
      
      public function TreasureSkillItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.tipDirctions = "0";
         this.tipGapH = 0;
         this.tipGapV = 5;
         this.isFollowMouse = false;
      }
      
      private function initView() : void
      {
         _item = ComponentFactory.Instance.creatCustomObject("TreasureSkillItem.item");
         _lock = ComponentFactory.Instance.creatBitmap("asset.theseus.skillLock");
         addChild(_item);
         addChild(_lock);
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         if(!param1)
         {
            _lock.visible = true;
            _loc3_ = int(TempleteManager.instance.theseusTreasureCoreCate.getSkillGrade(_index));
            _loc2_ = LanguageMgr.GetTranslation("TreasureSkillItem.tip.text",_loc3_);
            this.tipData = _loc2_;
         }
         else
         {
            _lock.visible = false;
            this.tipData = null;
            _item.icon.icon = IconFactory.getTecIconByIcon(param1.Icons);
            _item.icon.tipData = param1;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

