package sevenyear.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.battleflag.SevenYearAnswerView;
   import yishi.datas.templates.SevenYearQuestionTempInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class SevenYearAnswerItem extends Component
   {
      
      private var _redImg:Image;
      
      private var _greedImg:Image;
      
      private var _border:Image;
      
      private var _answerIndex:ScaleFrameImage;
      
      private var _answerTxt:FilterFrameText;
      
      private var _answerIcon:BaseIconView;
      
      private var _resultImg:ScaleFrameImage;
      
      private var _index:int;
      
      private var _data:SevenYearQuestionTempInfo;
      
      public function SevenYearAnswerItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
         this.buttonMode = true;
      }
      
      private function initView() : void
      {
         _redImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerItem.unSelectedImg");
         _greedImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerItem.selectedImg");
         _border = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerItem.border");
         _answerIndex = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerItem.answerIndex");
         _answerTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerItem.answerTxt");
         _answerIcon = ComponentFactory.Instance.creatCustomObject("SevenYearAnswerItem.answerIcon");
         _resultImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearAnswerItem.resultImg");
         addChild(_greedImg);
         addChild(_redImg);
         _redImg.visible = false;
         addChild(_border);
         _border.visible = false;
         addChild(_answerTxt);
         addChild(_answerIcon);
         addChild(_answerIndex);
         addChild(_resultImg);
         _resultImg.visible = false;
         _answerIndex.setFrame(_index + 1);
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__onMouseOver);
         addEventListener("rollOut",__onMouseOut);
         addEventListener("click",__onMouseClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__onMouseOver);
         removeEventListener("rollOut",__onMouseOut);
         removeEventListener("click",__onMouseClick);
      }
      
      private function __onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:SevenYearAnswerView = null;
         if(!_data)
         {
            return;
         }
         _border.visible = true;
         if(this.parent)
         {
            _loc2_ = this.parent as SevenYearAnswerView;
            if(_loc2_)
            {
               _loc2_.removeClick();
            }
         }
         SevenYearManager.instance.sendOp(7,"",_data.TemplateId);
      }
      
      public function refreshView() : void
      {
         clear();
         _data = model.answerTempInfoArr[_index];
         if(_data)
         {
            if(_data.AnswerName != "")
            {
               _answerTxt.text = _data.AnswerName;
               if(_answerTxt.numLines == 3)
               {
                  _answerTxt.y = 7;
               }
               else if(_answerTxt.numLines == 2)
               {
                  _answerTxt.y = 14;
               }
               else if(_answerTxt.numLines == 1)
               {
                  _answerTxt.y = 19;
               }
            }
            else if(_data.AnswerIconPath != "")
            {
               _answerIcon.icon = IconFactory.getSevenYearIconPath(_data.AnswerIconPath);
            }
         }
         var _loc1_:int = int(model.optionsArr[_index]);
         if(_index >= model.optionsArr.length)
         {
            _loc1_ = -1;
         }
         _border.visible = _loc1_ == model.myAnswer;
         if(model.rightAnswer > 0)
         {
            remove();
            if(_loc1_ == model.myAnswer)
            {
               if(model.rightAnswer == _loc1_)
               {
                  _resultImg.visible = true;
                  _resultImg.setFrame(2);
               }
               else
               {
                  _redImg.visible = true;
                  _resultImg.visible = true;
                  _resultImg.setFrame(1);
               }
            }
            else if(model.rightAnswer == _loc1_)
            {
               _resultImg.visible = true;
               _resultImg.setFrame(2);
            }
         }
         else if(model.myAnswer > 0)
         {
            remove();
         }
         else
         {
            initEvent();
         }
      }
      
      private function clear() : void
      {
         _data = null;
         _answerTxt.text = "";
         _answerIcon.icon = null;
         _redImg.visible = false;
         _border.visible = false;
         _resultImg.visible = false;
         this.buttonMode = true;
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         this.filters = [UIFilter.getLightingFilter()];
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         this.filters = [];
      }
      
      public function remove() : void
      {
         removeEvent();
         this.buttonMode = false;
         this.filters = [];
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_redImg);
         _redImg = null;
         ObjectUtils.disposeObject(_greedImg);
         _greedImg = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_answerIndex);
         _answerIndex = null;
         ObjectUtils.disposeObject(_answerTxt);
         _answerTxt = null;
         ObjectUtils.disposeObject(_answerIcon);
         _answerIcon = null;
         ObjectUtils.disposeObject(_resultImg);
         _resultImg = null;
         super.dispose();
      }
   }
}

