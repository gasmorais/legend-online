package yishi.view.tips
{
   import cell.view.starbag.StarBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyRewardData;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ContinuePayRebateChestIconTip extends BaseTip
   {
      
      private var _hbox:HBox;
      
      public function ContinuePayRebateChestIconTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _hbox = ComponentFactory.Instance.creatCustomObject("xmlui.advanceReward.hbox");
         addChild(_hbox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         var _loc6_:StarBagCell = null;
         var _loc4_:StarInfo = null;
         var _loc5_:FunnyBagData = _data as FunnyBagData;
         if(_loc5_ != null)
         {
            _hbox.beginChanges();
            _hbox.disposeAllChildren();
            for each(var _loc2_:FunnyRewardData in _data.rewardList)
            {
               if(_loc2_.temType == 1)
               {
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("ContinuePayRebateChestIconTip.BaseItemView");
                  _loc3_ = new GoodsInfo();
                  _loc3_.templateId = _loc2_.temId;
                  _loc3_.count = _loc2_.count;
                  _loc3_.isBinds = _loc2_.isBind;
                  _loc3_.isHideBinds = true;
                  _loc3_.strengthenGrade = _loc2_.strengthenGrade;
                  _loc1_.data = _loc3_;
                  _hbox.addChild(_loc1_);
               }
               else if(_loc2_.temType == 2)
               {
                  _loc6_ = ComponentFactory.Instance.creatCustomObject("continuePayRebate.rewardItem.StarBagCell");
                  _loc4_ = new StarInfo();
                  _loc4_.template = TempleteManager.instance.starTempalteCate.getTemplateByID(_loc2_.temId);
                  _loc4_.count = _loc2_.count;
                  _loc4_.grade = _loc2_.strengthenGrade;
                  _loc6_.data = _loc4_;
                  _loc6_.acceptDrop = false;
                  _loc6_.lock = false;
                  _hbox.addChild(_loc6_);
               }
               _hbox.commitChanges();
               _bg.width = _hbox.width + 29;
               _bg.height = 75;
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_hbox)
         {
            _hbox.disposeAllChildren();
            _hbox.dispose();
            _hbox = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

