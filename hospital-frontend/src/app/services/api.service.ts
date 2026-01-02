import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private patientUrl = 'http://192.168.111.129:3000/patients';
  private appointmentUrl = 'http://192.168.111.129:3001/appointments';

  constructor(private http: HttpClient) { }

  getPatients(): Observable<any> {
    return this.http.get(this.patientUrl);
  }

  createPatient(data: any): Observable<any> {
    return this.http.post(this.patientUrl, data);
  }

  getAppointments(): Observable<any> {
    return this.http.get(this.appointmentUrl);
  }

  createAppointment(data: any): Observable<any> {
    return this.http.post(this.appointmentUrl, data);
  }
}
