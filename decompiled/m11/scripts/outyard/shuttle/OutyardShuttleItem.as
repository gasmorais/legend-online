package outyard.shuttle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.templates.OutyardShuttleTemplateInfo;
   import yishi.manager.OutyardManager;
   import yishi.manager.TempleteManager;
   
   public class OutyardShuttleItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _levelImage:ScaleFrameImage;
      
      private var _scoreBmp:Bitmap;
      
      private var _leftBmp:Bitmap;
      
      private var _index:int;
      
      private var _data:OutyardShuttleTemplateInfo;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _leftTxt:FilterFrameText;
      
      public function OutyardShuttleItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttleItem.forbiddenBmp");
         _levelImage = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttleItem.levelImage");
         _scoreBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttleItem.scoreBmp");
         _leftBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttleItem.leftBmp");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.resetLeftTxt");
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.refreshLeftTxt");
         addChild(_bg);
         addChild(_levelImage);
         addChild(_scoreBmp);
         addChild(_leftBmp);
         addChild(_scoreTxt);
         addChild(_leftTxt);
         this.tipData = LanguageMgr.GetTranslation("outyard.OutyardShuttleItem.clickTips");
         this.buttonMode = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",_btnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",_btnClick);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _bg.setFrame(OutyardManager.instance.shuttleModel.shuttleMsg.currentDifficulty);
         _levelImage.setFrame(param1);
      }
      
      public function set leftCount(param1:int) : void
      {
         var _loc3_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         var _loc4_:Dictionary = TempleteManager.instance.outyardShuttleTemplateCate.getTemplates();
         for each(var _loc2_:OutyardShuttleTemplateInfo in _loc4_)
         {
            if(_loc2_.Difficulty == _loc3_.currentDifficulty && _loc2_.Area == _index)
            {
               _data = _loc2_;
               break;
            }
         }
         _scoreTxt.htmlText = String(_data.ShuttleScore) + addValue;
         _leftTxt.text = String(param1);
         _data.MaxChallenge > param1 ? _leftTxt.setFrame(2) : _leftTxt.setFrame(1);
         _bg.setFrame(OutyardManager.instance.shuttleModel.shuttleMsg.currentDifficulty);
      }
      
      private function get addValue() : String
      {
         var _loc3_:int = 0;
         var _loc1_:String = "";
         var _loc2_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(16);
         if(_loc2_)
         {
            _loc3_ = Math.floor(_loc2_.tempInfo.AddValue * _data.ShuttleScore / 100);
            _loc1_ = LanguageMgr.GetTranslation("PetContracAddTips.addvalueText.text",_loc3_);
         }
         return _loc1_;
      }
      
      private function _btnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         OutyardManager.instance.OperateShuttle(4,0,0,_index);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_levelImage);
         _levelImage = null;
         ObjectUtils.disposeObject(_scoreBmp);
         _scoreBmp = null;
         ObjectUtils.disposeObject(_leftBmp);
         _leftBmp = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_leftTxt);
         _leftTxt = null;
         _data = null;
         super.dispose();
      }
   }
}

