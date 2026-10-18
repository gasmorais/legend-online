package map.campaign.view.ui.molong
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.RollInfoMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.utils.MsgMan;
   import yishi.view.tools.QuickenMovieClip;
   
   public class ShaiziComp extends Component
   {
      
      private var _type:int;
      
      private var _mutipleShaizi:MutipleImage;
      
      private var _mc:QuickenMovieClip;
      
      private var _doBtn:IconButton;
      
      private var _text:FilterFrameText;
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _headId:int;
      
      private var _maskBg:DisplayObject;
      
      private var _isRoll:Boolean;
      
      private var shaiziEffectMC:DisplayObject;
      
      private var _num:int;
      
      private var _timer:Timer;
      
      public function ShaiziComp(param1:int, param2:String, param3:int, param4:int, param5:Boolean = false, param6:int = 2)
      {
         _userId = param3;
         _userName = param2;
         _headId = param1;
         _num = param4;
         _type = param6;
         _isRoll = param5;
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:DisplayObject = ComponentFactory.Instance.creat("asset.molong.shaiziBg");
         this.addChild(_loc1_);
         _mutipleShaizi = ComponentFactory.Instance.creatComponentByStylename("molong.mutipleShaizi");
         this.addChild(_mutipleShaizi);
         _mutipleShaizi.visible = false;
         var _loc2_:MovieClip = ComponentFactory.Instance.creatCustomObject("molong.shaiziMC");
         _mc = new QuickenMovieClip(_loc2_);
         _mc.gotoAndStop(0);
         this.addChild(_mc);
         _mc.addFrameScript(_mc.totalFrames - 1,mcPlayerOver);
         if(_isRoll)
         {
            _mc.visible = false;
            _mutipleShaizi.showImg(_num - 1);
            _mutipleShaizi.visible = true;
         }
         _maskBg = ComponentFactory.Instance.creat("asset.molong.shaiziMaskBg");
         if(_isRoll)
         {
            _maskBg.visible = false;
         }
         this.addChild(_maskBg);
         _text = ComponentFactory.Instance.creatComponentByStylename("molong.roleName");
         _text.text = _userName;
         this.addChild(_text);
         if(_type == 1)
         {
            _doBtn = ComponentFactory.Instance.creatComponentByStylename("molong.btnOk");
            this.addChild(_doBtn);
         }
         initEvent();
      }
      
      private function initEvent() : void
      {
         if(_doBtn)
         {
            _doBtn.addEventListener("click",clickHandler);
         }
         MsgMan.addObserver("map.campaign.view.ui.molong.UPDATE_SHAIZI_INFO" + _userId,this,updateShaiziInfo);
         MsgMan.addObserver("map.campaign.view.ui.molong.FALL_BOXES",this,finalShaizi);
      }
      
      private function removeEvent() : void
      {
         if(_doBtn)
         {
            _doBtn.removeEventListener("click",clickHandler);
         }
         MsgMan.removeObserver("map.campaign.view.ui.molong.UPDATE_SHAIZI_INFO" + _userId,this,updateShaiziInfo);
         MsgMan.removeObserver("map.campaign.view.ui.molong.FALL_BOXES",this,finalShaizi);
      }
      
      private function updateShaiziInfo(param1:String, param2:int) : void
      {
         MsgMan.removeObserver("map.campaign.view.ui.molong.UPDATE_SHAIZI_INFO" + _userId,this,updateShaiziInfo);
         _num = param2;
         _maskBg.visible = false;
         _mc.visible = true;
         _mc.play();
      }
      
      private function finalShaizi(param1:String, param2:Object) : void
      {
         var _loc3_:RollInfoMsg = param2 as RollInfoMsg;
         if(!_loc3_ || _loc3_.userId != _userId)
         {
            return;
         }
         _timer = new Timer(1000);
         _timer.addEventListener("timer",playerShaiziEffectMC);
         _timer.start();
      }
      
      private function playerShaiziEffectMC(param1:TimerEvent = null) : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",playerShaiziEffectMC);
            _timer.stop();
            _timer = null;
         }
         shaiziEffectMC = ComponentFactory.Instance.creat("asset.molong.shaiziEffectMC");
         this.addChild(shaiziEffectMC);
      }
      
      private function mcPlayerOver() : void
      {
         _mc.gotoAndStop(0);
         _mc.visible = false;
         this.removeChild(_mc);
         _mc.dispose();
         _mc = null;
         _mutipleShaizi.visible = true;
         _mutipleShaizi.showImg(_num - 1);
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         _maskBg.visible = false;
         _doBtn.enable = false;
         _mc.visible = true;
         _mc.play();
         MolongSocketOut.molongOperate(1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _mutipleShaizi.dispose();
         _mutipleShaizi = null;
         if(_mc)
         {
            this.removeChild(_mc);
            _mc.dispose();
            _mc = null;
         }
         if(_doBtn)
         {
            _doBtn.dispose();
            _doBtn = null;
         }
         _text.dispose();
         _text = null;
         Bitmap(_maskBg).bitmapData.dispose();
         _maskBg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

