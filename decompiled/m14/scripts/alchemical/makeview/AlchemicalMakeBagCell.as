package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.AlchemicalManager;
   import yishi.view.community.BaseItemView;
   
   public class AlchemicalMakeBagCell extends BaseItemView
   {
      
      private var lockBack:Bitmap;
      
      private var _tempInfo:GoodsTemplateInfo;
      
      public function AlchemicalMakeBagCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         lockBack = ComponentFactory.Instance.creatBitmap("asset.AlchemicalMakeBagCell.lockBack");
      }
      
      public function get tempInfo() : GoodsTemplateInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:GoodsTemplateInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         _tempInfo = param1;
         if(_tempInfo)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = tempInfo.TemplateId;
            _loc3_ = model.getAlchemicalItemById(tempInfo.TemplateId);
            if(_loc3_)
            {
               _loc2_.count = _loc3_.count;
            }
            super.data = _loc2_;
            _loc3_ && _loc3_.count > 0 ? (this.filters = []) : (this.filters = [UIFilter.getGrayFilter()]);
         }
         else
         {
            this.filters = [];
            if(lockBack && !lockBack.parent)
            {
               addChild(lockBack);
            }
         }
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(lockBack);
         lockBack = null;
         super.dispose();
      }
   }
}

