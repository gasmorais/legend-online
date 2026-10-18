package dayguide
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import managers.DayGuideManager;
   import mvc.module.dayGuide.DayGuideCatecory;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   
   public class DateItemView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _effect:MovieClip;
      
      private var _back:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      private var _today:Bitmap;
      
      private var _date:Date;
      
      public function DateItemView()
      {
         super();
         init();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,39,29);
      }
      
      private function init() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("dayGuide.DateItemViewBack");
         _txt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.DateItemViewTxt");
         _today = ComponentFactory.Instance.creatBitmap("asset.dayGuide.DateItemToday");
         _effect = ComponentFactory.Instance.creatCustomObject("dayGuide.DateItemViewEffect");
         addChild(_back);
         addChild(_txt);
         addChild(_today);
         addChild(_effect);
         _today.visible = false;
         _effect.gotoAndStop(1);
      }
      
      private function initEvent() : void
      {
         playerInfo.addEventListener("PLAYER_SIGNSITE_CHANGE",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         playerInfo.removeEventListener("PLAYER_SIGNSITE_CHANGE",__changeHandler);
      }
      
      private function __changeHandler(param1:PlayerEvent) : void
      {
         date = _date;
         showEffect();
      }
      
      public function get date() : Date
      {
         return _date;
      }
      
      public function set date(param1:Date) : void
      {
         _date = param1;
         _txt.text = _date.date.toString();
         _today.visible = false;
         if(_date.month < today.month || _date.month > today.month)
         {
            _back.setFrame(1);
            _txt.setFrame(1);
         }
         else if(!cate.hasSigned(_date))
         {
            if(_date.date == today.date)
            {
               _today.visible = true;
               _back.setFrame(3);
               _txt.setFrame(3);
               initEvent();
            }
            else if(_date.date <= today.date)
            {
               _back.setFrame(2);
               _txt.setFrame(2);
            }
            else
            {
               _back.setFrame(3);
               _txt.setFrame(3);
            }
            if(_date.day == 0 || _date.day == 6)
            {
               _txt.setFrame(5);
            }
         }
         else
         {
            _back.setFrame(3);
            _txt.setFrame(3);
            _effect.gotoAndStop(_effect.totalFrames);
            if(_date.day == 0 || _date.day == 6)
            {
               _txt.setFrame(5);
            }
         }
      }
      
      public function showEffect() : void
      {
         _effect.gotoAndPlay(2);
      }
      
      private function get cate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
      
      private function get today() : Date
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeViolentMc(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_today);
         _today = null;
         _date = null;
      }
   }
}

