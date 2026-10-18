package cultureactive
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.culture.OrderRewardMsg;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class CultureActiveSortRewardItem extends Component
   {
      
      private var _noteTxt:FilterFrameText;
      
      private var _vBox:VBox;
      
      public function CultureActiveSortRewardItem()
      {
         super();
      }
      
      public function set data(param1:OrderRewardMsg) : void
      {
         var _loc2_:Array = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:FilterFrameText = null;
         var _loc6_:int = 0;
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortRewardItem.noteTxt");
         addChild(_noteTxt);
         _noteTxt.text = LanguageMgr.GetTranslation("CultureActiveSortRewardItem.noteTxt.text",param1.order1,param1.order2);
         _vBox = new VBox();
         _vBox.x = 70;
         addChild(_vBox);
         var _loc5_:Array = param1.rewardItems.split("|");
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc6_].split(",");
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_[0]);
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("CultureActiveSortRewardItem.OrderRewardTxt");
            _loc4_.text = _loc3_.TemplateName + "*" + _loc2_[1];
            _vBox.addChild(_loc4_);
            _loc6_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}

