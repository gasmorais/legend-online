package allmanexchange.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.allmanexchange.AllManExchangeModel;
   import yishi.manager.AllManExchangeManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AllManExchangeSmallBox extends Component
   {
      
      private var _imgSmallBox:ScaleFrameImage;
      
      private var _txtSingleBoxScore:FilterFrameText;
      
      private var _txtCanGetStr:FilterFrameText;
      
      private var index:int;
      
      private var spClick:Sprite;
      
      public function AllManExchangeSmallBox(param1:int)
      {
         super();
         this.index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _imgSmallBox = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.imgSmallBox");
         _txtSingleBoxScore = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtSingleBoxScore");
         _txtCanGetStr = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtCanGetStr");
         addChild(_imgSmallBox);
         addChild(_txtSingleBoxScore);
         addChild(_txtCanGetStr);
         _imgSmallBox.setFrame(1);
         _txtCanGetStr.text = LanguageMgr.GetTranslation("allmainexchange.str5");
         _txtSingleBoxScore.text = "1000";
         spClick = new Sprite();
         spClick.graphics.beginFill(16777215,0);
         spClick.graphics.drawRect(40,25,65,65);
         spClick.graphics.endFill();
         spClick.buttonMode = true;
         addChild(spClick);
         tipStyle = "yishi.view.tips.OneLineTip";
         tipDirctions = "7,5,4,6";
         tipGapV = 0;
         isFollowMouse = false;
      }
      
      private function addEvent() : void
      {
         spClick.addEventListener("click",onClickGet);
      }
      
      private function removeEvent() : void
      {
         spClick.removeEventListener("click",onClickGet);
      }
      
      private function onClickGet(param1:MouseEvent) : void
      {
         if(_imgSmallBox.getFrame == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("allmainexchange.str10"));
            return;
         }
         if(_imgSmallBox.getFrame == 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("allmainexchange.str8"));
            return;
         }
         AllManExchangeManager.instance.sendGetAward(2,index);
      }
      
      public function update() : void
      {
         _txtSingleBoxScore.text = model.allPointAward[index];
         if(model.allPoint >= model.allPointAward[index])
         {
            if(model.serverAwardState[index] == 1)
            {
               _imgSmallBox.setFrame(3);
            }
            else
            {
               _imgSmallBox.setFrame(2);
            }
         }
         else
         {
            _imgSmallBox.setFrame(1);
         }
         tipData = model.getSmallBoxTip(index + 1);
      }
      
      private function get model() : AllManExchangeModel
      {
         return AllManExchangeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_imgSmallBox);
         _imgSmallBox = null;
         ObjectUtils.disposeObject(_txtSingleBoxScore);
         _txtSingleBoxScore = null;
         ObjectUtils.disposeObject(_txtCanGetStr);
         _txtCanGetStr = null;
         ObjectUtils.disposeObject(spClick);
         spClick = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

