package goddess.page
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessBaseView extends Component
   {
      
      protected var _inputTxt:FilterFrameText;
      
      protected var _data:GoddessInfo;
      
      protected var _needItemId:int;
      
      protected var _gInfo:GoodsInfo;
      
      protected var _needItemTempInfo:GoodsTemplateInfo;
      
      protected var _hasGoodsNum:int;
      
      protected var _lastHasGoodsNum:int;
      
      protected var _isDispose:Boolean = false;
      
      public function GoddessBaseView()
      {
         super();
      }
      
      protected function initEvent() : void
      {
         if(_inputTxt)
         {
            _inputTxt.addEventListener("change",inputChangeHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",inputChangeHandler);
         }
      }
      
      protected function set needItemId(param1:int) : void
      {
         _hasGoodsNum = GoodsManager.instance.getGoodsNumByTempId(param1);
         if(_needItemId == param1)
         {
            return;
         }
         _needItemId = param1;
         _needItemTempInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_needItemId);
         _gInfo = new GoodsInfo();
         _gInfo.templateId = _needItemId;
      }
      
      protected function showAddExp() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = _lastHasGoodsNum - _hasGoodsNum;
         if(_loc2_ > 0 && _lastHasGoodsNum > 0)
         {
            if(_needItemTempInfo)
            {
               _loc1_ = _needItemTempInfo.Property1 * _loc2_;
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.addExp",_loc1_));
            }
         }
      }
      
      private function inputChangeHandler(param1:Event) : void
      {
         var _loc2_:int = int(_inputTxt.text);
         if(_loc2_ > _hasGoodsNum)
         {
            _inputTxt.text = _hasGoodsNum + "";
         }
      }
      
      override public function dispose() : void
      {
         _isDispose = true;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         super.dispose();
         _gInfo = null;
         _needItemTempInfo = null;
         _data = null;
      }
      
      public function get data() : GoddessInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         if(_isDispose)
         {
            return;
         }
         _data = param1;
      }
   }
}

