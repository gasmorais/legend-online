package foisonhorn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import managers.FoisonHornManager;
   import mvc.module.foisonhorn.FoisonHornModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   
   public class FoisonHornItem extends Component
   {
      
      private var _index:int = -1;
      
      private var _item:BaseItemView;
      
      private var _processText:FilterFrameText;
      
      private var info:GoodsInfo;
      
      private var _canActive:Boolean;
      
      public function FoisonHornItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _item = ComponentFactory.Instance.creatCustomObject("foisonHornItem.itemView");
         _processText = ComponentFactory.Instance.creatComponentByStylename("foisonHornItem.processText");
         _processText = ComponentFactory.Instance.creatComponentByStylename("foisonHornItem.processText");
         addChild(_processText);
         addChild(_item);
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         _canActive = false;
         if(_index > -1 && _index < model.goodsList.length)
         {
            info = model.goodsList[_index];
            if(!info)
            {
               return;
            }
            _item.data = info;
            _loc1_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(info.templateId));
            _processText.text = _loc1_ + "/" + info.count;
            if(isActivated)
            {
               _item.filters = null;
               _processText.setFrame(1);
               _processText.text = "";
               _processText.setFrame(1);
               _processText.text = "";
            }
            else
            {
               _item.filters = [UIFilter.getGrayFilter()];
               if(_loc1_ >= info.count)
               {
                  _canActive = true;
                  _processText.setFrame(1);
               }
               else
               {
                  _processText.setFrame(2);
                  _processText.setFrame(2);
               }
            }
         }
      }
      
      public function get canActive() : Boolean
      {
         return _canActive;
      }
      
      public function get isActivated() : Boolean
      {
         if(_index > -1 && _index < model.goodsList.length)
         {
            return model.activatingList[_index] == 1;
         }
         return false;
      }
      
      private function get model() : FoisonHornModel
      {
         return FoisonHornManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_processText);
         _processText = null;
         super.dispose();
      }
   }
}

