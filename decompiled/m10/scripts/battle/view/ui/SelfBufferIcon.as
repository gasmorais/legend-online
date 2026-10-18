package battle.view.ui
{
   import battle.data.BufferDamageData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class SelfBufferIcon extends BaseIconView implements Disposeable
   {
      
      private var _layerCount:FilterFrameText;
      
      private var _buffer:BufferDamageData;
      
      public function SelfBufferIcon()
      {
         super();
         initView();
         refreshView();
      }
      
      public function set buffer(param1:BufferDamageData) : void
      {
         if(_buffer == param1)
         {
            return;
         }
         _buffer = param1;
         refreshView();
      }
      
      private function initView() : void
      {
         _layerCount = ComponentFactory.Instance.creatComponentByStylename("battle.SelfBufferIcon.LayerCount");
         _layerCount.filters = [];
      }
      
      override protected function addChildren() : void
      {
         if(_iconContainer)
         {
            addChild(_iconContainer);
         }
         if(_loading)
         {
            addChild(_loading);
            _loading.mouseChildren = _loading.mouseEnabled = false;
         }
         if(_layerCount)
         {
            addChild(_layerCount);
         }
      }
      
      public function refreshView() : void
      {
         if(!_buffer)
         {
            return;
         }
         var _loc1_:BufferTemplateInfo = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_buffer.templateId);
         if(_buffer.layerCount > 1 && _loc1_.PressCount > 0)
         {
            _layerCount.text = _buffer.layerCount + "";
         }
         else
         {
            _layerCount.text = "";
         }
         icon = IconFactory.getCommonIconPath(_loc1_.Icon);
         tipData = _buffer;
      }
      
      private function getBufferName(param1:BufferTemplateInfo) : String
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         if(param1)
         {
            _loc3_ = StringHelper.getSubStrBetweenTwoChar("{","}",param1.BufferName);
            if(StringHelper.isNullOrEmpty(_loc3_))
            {
               return param1.BufferName;
            }
            _loc2_ = param1.hasOwnProperty(_loc3_) ? Math.abs(param1[_loc3_]) * _buffer.layerCount : 0;
            return StringHelper.replaceStr(param1.BufferName,"{" + _loc3_ + "}",String(_loc2_));
         }
         return "";
      }
      
      override public function dispose() : void
      {
         ShowTipManager.Instance.hideTip(this);
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeObject(_layerCount);
         _layerCount = null;
         _buffer = null;
         super.dispose();
      }
   }
}

