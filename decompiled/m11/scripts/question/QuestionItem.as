package question
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.templates.QuestionTempInfo;
   import yishi.view.base.GroupSelectObj;
   
   public class QuestionItem extends Sprite implements Disposeable
   {
      
      private var _subjectTxt:FilterFrameText;
      
      private var _group:GroupSelectObj;
      
      private var _line:Bitmap;
      
      private var _data:QuestionTempInfo;
      
      public function QuestionItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _subjectTxt = ComponentFactory.Instance.creatComponentByStylename("questionItem.subjectTxt");
         _group = ComponentFactory.Instance.creatComponentByStylename("questionItem.groupSelectObj");
         _line = ComponentFactory.Instance.creatBitmap("asset.core.tipsLineImg");
         addChild(_subjectTxt);
         addChild(_group);
         addChild(_line);
         _line.width = 412;
      }
      
      private function addEvent() : void
      {
         _group.addEventListener("change",__tabChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _group.removeEventListener("change",__tabChangeHandler);
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         _data.str = _group.selectString;
      }
      
      public function set data(param1:QuestionTempInfo) : void
      {
         var _loc5_:SelectedCheckButton = null;
         var _loc3_:Array = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         _data = param1;
         var _loc2_:String = "";
         ObjectUtils.disposeAllChildren(_group);
         if(_data)
         {
            _subjectTxt.text = LanguageMgr.GetTranslation("questionItem.subjectTxt.text",_data.Id,_data.Subject);
            _group.lock = _data.MaxChoose;
            _group.selectString = _data.str;
            _loc3_ = _data.Options.split("|");
            _loc6_ = _data.str.split(",");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = _loc3_[_loc4_];
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("questionItem.SelectedCheckButton");
               _loc5_.text = _loc2_;
               _loc5_.selected = _loc6_.indexOf("" + _loc4_) != -1;
               _group.addItem(_loc5_);
               _loc4_++;
            }
            _group.y = _subjectTxt.y + _subjectTxt.textHeight + 10;
            _line.y = _group.y + _group.height + 10;
         }
      }
      
      public function get data() : QuestionTempInfo
      {
         return _data;
      }
      
      public function set setEnable(param1:Boolean) : void
      {
         this.mouseChildren = this.mouseEnabled = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _data = null;
         ObjectUtils.disposeObject(_subjectTxt);
         _subjectTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeAllChildren(_group);
         _group = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

