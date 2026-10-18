package demonland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.datas.templates.DemonLandBoxDropTemplate;
   import yishi.manager.DemonLandManager;
   import yishi.manager.TempleteManager;
   
   public class AwardBox extends Component
   {
      
      private var _txtStar:FilterFrameText;
      
      private var _btnBox:BaseButton;
      
      private var _star:ScaleFrameImage;
      
      private var _imgGet:Image;
      
      private var arrCount:Array = [5,10,15,20,25,30];
      
      private var index:int;
      
      private var thisCount:int;
      
      public function AwardBox(param1:int)
      {
         this.index = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _btnBox = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardBox.box");
         addChild(_btnBox);
         _star = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardBox.star");
         addChild(_star);
         _txtStar = ComponentFactory.Instance.creatComponentByStylename("DemonLand.AwardBox.txtStar");
         addChild(_txtStar);
         _imgGet = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandFrame.awardGet");
         addChild(_imgGet);
         thisCount = arrCount[index - 1];
         _txtStar.text = thisCount + "";
         update();
         var _loc2_:Array = TempleteManager.instance.demonLandBoxDropTemplateCate.getAwardByStar(thisCount);
         var _loc1_:String = "";
         var _loc4_:int = 0;
         for each(var _loc3_:DemonLandBoxDropTemplate in _loc2_)
         {
            _loc4_++;
            _loc1_ += TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.itemId).TemplateName + "×" + _loc3_.count;
            if(_loc4_ % 3 == 0)
            {
               _loc1_ += "\n";
            }
            if(_loc4_ < _loc2_.length)
            {
               _loc1_ += ",";
            }
         }
         tipData = _loc1_;
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         if(DemonLandManager.instance.model.myStar < thisCount)
         {
            _btnBox.enable = false;
            _imgGet.visible = false;
         }
         else
         {
            _btnBox.enable = true;
            if(DemonLandManager.instance.model.boxState)
            {
               _loc1_ = int(DemonLandManager.instance.model.boxState.split(",")[index - 1]);
               if(_loc1_ == 0)
               {
                  _imgGet.visible = false;
               }
               else
               {
                  _imgGet.visible = true;
               }
            }
         }
      }
      
      private function addEvent() : void
      {
         _btnBox.addEventListener("click",onClickBox);
      }
      
      private function removeEvent() : void
      {
         if(_btnBox)
         {
            _btnBox.removeEventListener("click",onClickBox);
         }
      }
      
      private function onClickBox(param1:MouseEvent) : void
      {
         DemonLandManager.instance.sendOpenAwardBox(index - 1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         arrCount = null;
         ObjectUtils.disposeObject(_txtStar);
         _txtStar = null;
         ObjectUtils.disposeObject(_btnBox);
         _btnBox = null;
         ObjectUtils.disposeObject(_star);
         _star = null;
         ObjectUtils.disposeObject(_imgGet);
         _imgGet = null;
         super.dispose();
      }
   }
}

