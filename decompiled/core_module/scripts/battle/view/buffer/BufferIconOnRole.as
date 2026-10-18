package battle.view.buffer
{
   import battle.data.BufferDamageData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class BufferIconOnRole extends Sprite implements Disposeable
   {
      
      private var _icon:String;
      
      protected var _iconView:BaseIconView;
      
      protected var _buffer:Object;
      
      private var _layerCountTxt:FilterFrameText;
      
      private var _isDie:Boolean = false;
      
      public function BufferIconOnRole(param1:String = null, param2:Object = null)
      {
         super();
         init();
         if(param1 && param2)
         {
            setData(param1,param2);
         }
      }
      
      public function setData(param1:String, param2:Object) : void
      {
         _icon = param1;
         _buffer = param2;
         _iconView.icon = IconFactory.getCommonIconPath(_icon);
         refreshTurn();
      }
      
      public function refreshTurn() : void
      {
         var _loc2_:BufferDamageData = null;
         var _loc1_:BufferTemplateInfo = null;
         var _loc3_:BufferTemplateInfo = null;
         if(_buffer is BufferDamageData)
         {
            _loc2_ = _buffer as BufferDamageData;
            _loc1_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc2_.templateId);
            if(_loc2_.layerCount > 1 && _loc1_.PressCount > 0)
            {
               _layerCountTxt.text = _loc2_.layerCount + "";
            }
            else
            {
               _layerCountTxt.text = "";
            }
            _iconView.tipData = _buffer;
         }
         else if(_buffer is BufferTemplateInfo)
         {
            _loc3_ = _buffer as BufferTemplateInfo;
            if(_loc3_.MultiLordsInspireLevel > 1)
            {
               _layerCountTxt.text = _loc3_.MultiLordsInspireLevel + "";
            }
            else
            {
               _layerCountTxt.text = "";
            }
            _iconView.tipData = _buffer;
         }
      }
      
      public function dispose() : void
      {
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         ShowTipManager.Instance.hideTip(_iconView);
         ShowTipManager.Instance.removeTip(_iconView);
         if(_iconView)
         {
            ObjectUtils.disposeObject(_iconView);
         }
         _iconView = null;
         if(_layerCountTxt)
         {
            ObjectUtils.disposeObject(_layerCountTxt);
         }
         _layerCountTxt = null;
         _buffer = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get buffer() : Object
      {
         return _buffer;
      }
      
      public function set buffer(param1:Object) : void
      {
         _buffer = param1;
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
      
      private function init() : void
      {
         _iconView = ComponentFactory.Instance.creatCustomObject("battle.BufferIconView");
         _layerCountTxt = ComponentFactory.Instance.creatComponentByStylename("tips.BufferLayerNumText");
         _layerCountTxt.text = "";
         addChild(_iconView);
         addChild(_layerCountTxt);
      }
   }
}

